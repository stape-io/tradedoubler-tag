const BigQuery = require('BigQuery');
const encodeUriComponent = require('encodeUriComponent');
const getAllEventData = require('getAllEventData');
const getContainerVersion = require('getContainerVersion');
const getCookieValues = require('getCookieValues');
const getRequestHeader = require('getRequestHeader');
const getTimestampMillis = require('getTimestampMillis');
const getType = require('getType');
const JSON = require('JSON');
const logToConsole = require('logToConsole');
const makeInteger = require('makeInteger');
const makeString = require('makeString');
const Object = require('Object');
const parseUrl = require('parseUrl');
const sendHttpRequest = require('sendHttpRequest');
const setCookie = require('setCookie');
const sha256Sync = require('sha256Sync');

/*==============================================================================
==============================================================================*/

const traceId = getRequestHeader('trace-id');

const eventData = getAllEventData();

const useOptimisticScenario = isUIFieldTrue(data.useOptimisticScenario);

if (!isConsentGivenOrNotRequired()) {
  return data.gtmOnSuccess();
}

const url = eventData.page_location || getRequestHeader('referer');
if (url && url.lastIndexOf('https://gtm-msr.appspot.com/', 0) === 0) {
  return data.gtmOnSuccess();
}

const actionHandlers = {
  pageView: handlePageViewEvent,
  userData: handleUserDataEvent,
  conversion: handleConversionEvent
};

const handler = actionHandlers[data.type];
if (handler) {
  handler(data, eventData);
} else {
  return data.gtmOnFailure();
}

if (useOptimisticScenario) {
  return data.gtmOnSuccess();
}

/*==============================================================================
  Vendor related functions
==============================================================================*/

function handlePageViewEvent(data, eventData) {
  const url = eventData.page_location || getRequestHeader('referer');
  if (!url) return data.gtmOnSuccess();

  const cookieOptions = {
    domain: data.cookieDomain || 'auto',
    samesite: 'Lax',
    path: '/',
    secure: true,
    httpOnly: !!data.cookieHttpOnly,
    'max-age': 60 * 60 * 24 * (makeInteger(data.cookieExpiration) || 365)
  };

  const urlSearchParams = parseUrl(url).searchParams;

  const tduicClickIdValue =
    urlSearchParams[data.tduidClickIdParameterName || 'tduid'] || urlSearchParams.deviceid;
  if (tduicClickIdValue) {
    setCookie('tduid', tduicClickIdValue, cookieOptions, false);
  }

  const tdclidClickIdValue = urlSearchParams[data.tdclidClickIdParameterName || 'tdclid_sn'];
  if (tdclidClickIdValue) {
    setCookie('tdclid_sn', tdclidClickIdValue, cookieOptions, false);
  }

  return data.gtmOnSuccess();
}

function handleUserDataEvent(data, eventData) {
  const requestData = mapRequestData(data, eventData);

  const missingParameters = areThereRequiredParametersMissing(requestData);
  if (missingParameters) {
    log({
      Name: 'Tradedoubler',
      Type: 'Message',
      TraceId: traceId,
      EventName: data.type,
      Message: 'Request was not sent.',
      Reason: 'One or more required properties are missing: ' + missingParameters.join(' or ')
    });

    return data.gtmOnFailure();
  }

  return sendRequest(data, requestData);
}

function handleConversionEvent(data, eventData) {
  const requestData = mapRequestData(data, eventData);

  const missingParameters = areThereRequiredParametersMissing(requestData);
  if (missingParameters) {
    log({
      Name: 'Tradedoubler',
      Type: 'Message',
      TraceId: traceId,
      EventName: data.type,
      Message: 'Request was not sent.',
      Reason: 'One or more required properties are missing: ' + missingParameters.join(' or ')
    });

    return data.gtmOnFailure();
  }

  return sendRequest(data, requestData);
}

function mapRequestData(data, eventData) {
  let requestData = {
    organization: data.organizationId,
    convtagtid: '11'
  };

  if (data.type === 'conversion') {
    requestData = addConversionData(data, eventData, requestData);
    requestData = addProductsData(data, eventData, requestData);
  }

  requestData = addCrossDeviceData(data, eventData, requestData);
  requestData = hashDataIfNeeded(requestData);

  return requestData;
}

function addConversionData(data, eventData, requestData) {
  requestData.program = data.programId;
  requestData.event = data.eventId;

  if (isValidValue(data.orderValue)) requestData.ordervalue = makeString(data.orderValue);
  else if (isValidValue(eventData.value)) requestData.ordervalue = makeString(eventData.value);

  const leadOrOrderNumber =
    data.leadOrOrderNumber || eventData.orderId || eventData.order_id || eventData.transaction_id;
  if (data.conversionType === 'leads') requestData.leadnumber = leadOrOrderNumber;
  else requestData.ordernumber = leadOrOrderNumber;

  const tduidClickId = data.hasOwnProperty('tduidClickId')
    ? data.tduidClickId
    : getCookieValues('tduid')[0];
  if (tduidClickId) requestData.tduid = tduidClickId;

  const tdclidClickId = data.hasOwnProperty('tdclidClickId')
    ? data.tdclidClickId
    : getCookieValues('tdclid_sn')[0];
  if (tdclidClickId) requestData.tdclid = tdclidClickId;

  const currency = data.hasOwnProperty('currency')
    ? data.currency
    : eventData.currency || eventData.currencyCode;
  if (currency) requestData.currency = currency;

  const voucher = data.hasOwnProperty('voucher') ? data.voucher : eventData.coupon;
  if (voucher) requestData.voucher = voucher;

  const eventTime = data.eventTime;
  if (eventTime && validateEventTime(eventTime)) requestData.event_time = eventTime;

  const validOn = data.validOn;
  if (validOn && validateValidOn(validOn)) requestData.validOn = validOn;

  return requestData;
}

function addProductsData(data, eventData, requestData) {
  let products = [];
  if (data.hasOwnProperty('products')) products = data.products;
  else if (getType(eventData.items) === 'array' && eventData.items.length) {
    eventData.items.forEach((item) => {
      const product = {};
      if (item.item_id) product.item_id = makeString(item.item_id);
      if (data.enablePLT && item.item_group_id) {
        product.item_group_id = makeString(item.item_group_id);
      }
      if (item.item_name) product.item_name = item.item_name;
      if (item.quantity) product.quantity = item.quantity;
      if (item.price) product.price = item.price;
      products.push(product);
    });
  }

  if (getType(products) === 'array' && products.length) {
    if (data.enablePLT) {
      products.forEach((product) => {
        if (product.item_id) {
          product.item_id = sanitizeValueForPLT(product.item_id.substring(0, 20));
        }
        if (product.item_name) {
          product.item_name = sanitizeValueForPLT(product.item_name.substring(0, 20));
        }
      });
      requestData.basket = products;
      requestData.enc = '3';
    } else requestData.reportInfo = products;
  }

  return requestData;
}

function addCrossDeviceData(data, eventData, requestData) {
  const eventDataUserData = eventData.user_data || {};

  let email = data.hasOwnProperty('userEmail')
    ? data.userEmail
    : eventData.email ||
      eventData.email_address ||
      eventDataUserData.email ||
      eventDataUserData.email_address ||
      eventDataUserData.sha256_email_address;
  const emailType = getType(email);
  if (emailType === 'array' || emailType === 'object') email = email[0] ? email[0] : undefined;

  const userId = data.hasOwnProperty('userId') ? data.userId : eventData.user_id;

  if (email) {
    requestData.extid = email;
    requestData.exttype = 1;
  } else if (userId) {
    requestData.extid = userId;
    requestData.exttype = 0;
  }

  const deviceId = data.hasOwnProperty('userDeviceId')
    ? data.userDeviceId
    : eventData['x-ga-resettable_device_id'];
  if (deviceId) requestData.deviceid = deviceId;

  return requestData;
}

function hashData(value) {
  if (!value) return value;

  const type = getType(value);

  if (value === 'undefined' || value === 'null') return undefined;

  if (type === 'array') {
    return value.map((val) => hashData(val));
  }

  if (type === 'object') {
    return Object.keys(value).reduce((acc, val) => {
      acc[val] = hashData(value[val]);
      return acc;
    }, {});
  }

  if (isHashed(value)) return value;

  return sha256Sync(makeString(value).trim().toLowerCase(), {
    outputEncoding: 'hex'
  });
}

function hashDataIfNeeded(requestData) {
  const userDataKeysToHash = ['extid'];
  userDataKeysToHash.forEach((key) => {
    const value = requestData[key];
    if (!value) return;
    requestData[key] = hashData(value);
  });

  return requestData;
}

function validateEventTime(value) {
  if (!value) return false;
  return makeString(value).match('^\\d{4}-\\d{2}-\\d{2}\\s\\d{2}:\\d{2}:\\d{2}$') !== null;
}

function validateValidOn(value) {
  if (!value) return false;
  return makeString(value).match('^\\d{4}-\\d{2}-\\d{2}$') !== null;
}

function areThereRequiredParametersMissing(requestData) {
  const requiredParametersByEventType = {
    userData: ['organization', 'exttype'],
    conversion: [
      'organization',
      'event',
      data.conversionType === 'leads' ? 'leadnumber' : 'ordernumber'
    ]
  };
  if (data.conversionType === 'sales') {
    requiredParametersByEventType.conversion.push('currency');

    if (!data.enablePLT) requiredParametersByEventType.conversion.push('ordervalue');
    else requiredParametersByEventType.conversion.push('basket');
  }

  const requiredParameters = requiredParametersByEventType[data.type];
  const anyMissing = requiredParameters.some((p) => {
    const value = requestData[p];
    if (!isValidValue(value)) return true;

    if (p === 'basket') {
      if (getType(value) !== 'array' || value.length === 0) return true;

      const anyProductMissingAParameter = value.some((product) => {
        const requiredProductParameters = [
          'item_id',
          'item_name',
          'item_group_id',
          'price',
          'quantity'
        ];

        const anyProductParameterMissing = requiredProductParameters.some(
          (productParameter) => !isValidValue(product[productParameter])
        );

        if (anyProductParameterMissing) return true;
        return false;
      });

      if (anyProductMissingAParameter) return true;
    }
  });

  if (anyMissing) return requiredParameters;
}

function sendRequest(data, requestData) {
  const requestUrl =
    getRequestBaseUrl(data) +
    getRequestPath(data) +
    '?' +
    getRequestUrlParameters(data, requestData);

  log({
    Name: 'Tradedoubler',
    Type: 'Request',
    TraceId: traceId,
    EventName: data.type,
    RequestMethod: 'GET',
    RequestUrl: requestUrl
  });

  return sendHttpRequest(
    requestUrl,
    (statusCode, headers, body) => {
      log({
        Name: 'Tradedoubler',
        Type: 'Response',
        TraceId: traceId,
        EventName: data.type,
        ResponseStatusCode: statusCode,
        ResponseHeaders: headers,
        ResponseBody: body
      });

      if (!useOptimisticScenario) {
        if (statusCode >= 200 && statusCode < 400) {
          data.gtmOnSuccess();
        } else {
          data.gtmOnFailure();
        }
      }
    },
    {
      headers: getRequestHeaders(data, eventData),
      method: 'GET'
    }
  );
}

function getRequestHeaders(data, eventData) {
  const requestHeaders = {};
  if (!isUIFieldTrue(data.redactIpAddress) && eventData.ip_override) {
    requestHeaders['X-Forwarded-For'] = eventData.ip_override;
  }
  return requestHeaders;
}

function getRequestBaseUrl(data) {
  return data.conversionType === 'leads'
    ? 'https://tbl.tradedoubler.com'
    : 'https://tbs.tradedoubler.com';
}

function getRequestPath(data) {
  const eventTypeToRequestPath = {
    userData: '/user',
    conversion: '/report'
  };

  return eventTypeToRequestPath[data.type];
}

function getRequestUrlParameters(data, requestData) {
  const requestParametersList = [];
  const regularToPLTFormatMapping = {
    organization: 'o',
    program: 'p',
    ordernumber: 'ordnum',
    currency: 'curr'
  };
  const unsupportedParametersInPLT = {
    validOn: true
  };
  const formatPLTBasket = (product) => {
    // prettier-ignore
    return (
      'pr(' +
        'i('  + product.item_id       + ')' +
        'n('  + product.item_name     + ')' +
        'gr(' + product.item_group_id + ')' +
        'v('  + product.price         + ')' +
        'q('  + product.quantity      + ')' +
      ')'
    );
  };
  const formatReportInfo = (product) => {
    // prettier-ignore
    return (
      'f1=' + product.item_id   + '&' +
      'f2=' + product.item_name + '&' +
      'f3=' + product.price     + '&' +
      'f4=' + product.quantity
    );
  };

  for (const key in requestData) {
    let value = requestData[key];
    if (!isValidValue(value)) continue;

    if (data.enablePLT && !unsupportedParametersInPLT[key]) {
      const mappedPLTKey = regularToPLTFormatMapping[key] || key;
      if (mappedPLTKey === 'basket') {
        value = value.map(formatPLTBasket).join('');
      }
      requestParametersList.push(enc(mappedPLTKey) + '(' + enc(value) + ')');
    } else if (!data.enablePLT) {
      if (key === 'reportInfo') continue;
      requestParametersList.push(enc(key) + '=' + enc(value));
    }
  }

  // It needs to be the last parameter.
  if (!data.enablePLT && requestData.reportInfo) {
    const reportInfoFormatted = requestData.reportInfo.map(formatReportInfo).join('|');
    requestParametersList.push(enc('reportInfo') + '=' + enc(reportInfoFormatted));
  }

  if (data.enablePLT) return requestParametersList.join('');
  return requestParametersList.join('&');
}

/*==============================================================================
  Helpers
==============================================================================*/

function sanitizeValueForPLT(value) {
  return (value || '')
    .split('[')
    .join('')
    .split(']')
    .join('')
    .split('(')
    .join('')
    .split(')')
    .join('');
}

function isHashed(value) {
  if (!value) return false;
  return makeString(value).match('^[A-Fa-f0-9]{64}$') !== null;
}

function isUIFieldTrue(field) {
  return [true, 'true'].indexOf(field) !== -1;
}

function isValidValue(value) {
  const valueType = getType(value);
  return valueType !== 'null' && valueType !== 'undefined' && value !== '';
}

function enc(data) {
  if (data === undefined || data === null) data = '';
  return encodeUriComponent(makeString(data));
}

function isConsentGivenOrNotRequired() {
  if (data.adStorageConsent !== 'required') return true;
  if (eventData.consent_state) return !!eventData.consent_state.ad_storage;
  const xGaGcs = eventData['x-ga-gcs'] || ''; // x-ga-gcs is a string like "G110"
  return xGaGcs[2] === '1';
}

function log(rawDataToLog) {
  const logDestinationsHandlers = {};
  if (determinateIsLoggingEnabled()) logDestinationsHandlers.console = logConsole;
  if (determinateIsLoggingEnabledForBigQuery()) logDestinationsHandlers.bigQuery = logToBigQuery;

  const keyMappings = {
    // No transformation for Console is needed.
    bigQuery: {
      Name: 'tag_name',
      Type: 'type',
      TraceId: 'trace_id',
      EventName: 'event_name',
      RequestMethod: 'request_method',
      RequestUrl: 'request_url',
      RequestBody: 'request_body',
      ResponseStatusCode: 'response_status_code',
      ResponseHeaders: 'response_headers',
      ResponseBody: 'response_body'
    }
  };

  for (const logDestination in logDestinationsHandlers) {
    const handler = logDestinationsHandlers[logDestination];
    if (!handler) continue;

    const mapping = keyMappings[logDestination];
    const dataToLog = mapping ? {} : rawDataToLog;

    if (mapping) {
      for (const key in rawDataToLog) {
        const mappedKey = mapping[key] || key;
        dataToLog[mappedKey] = rawDataToLog[key];
      }
    }

    handler(dataToLog);
  }
}

function logConsole(dataToLog) {
  logToConsole(JSON.stringify(dataToLog));
}

function logToBigQuery(dataToLog) {
  const connectionInfo = {
    projectId: data.logBigQueryProjectId,
    datasetId: data.logBigQueryDatasetId,
    tableId: data.logBigQueryTableId
  };

  dataToLog.timestamp = getTimestampMillis();

  ['request_body', 'response_headers', 'response_body'].forEach((p) => {
    dataToLog[p] = JSON.stringify(dataToLog[p]);
  });

  const bigquery =
    getType(BigQuery) === 'function' ? BigQuery() /* Only during Unit Tests */ : BigQuery;
  bigquery.insert(connectionInfo, [dataToLog], { ignoreUnknownValues: true });
}

function determinateIsLoggingEnabled() {
  const containerVersion = getContainerVersion();
  const isDebug = !!(
    containerVersion &&
    (containerVersion.debugMode || containerVersion.previewMode)
  );

  if (!data.logType) {
    return isDebug;
  }

  if (data.logType === 'no') {
    return false;
  }

  if (data.logType === 'debug') {
    return isDebug;
  }

  return data.logType === 'always';
}

function determinateIsLoggingEnabledForBigQuery() {
  if (data.bigQueryLogType === 'no') return false;
  return data.bigQueryLogType === 'always';
}
