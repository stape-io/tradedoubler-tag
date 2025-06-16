___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Tradedoubler Tag",
  "categories": [
    "AFFILIATE_MARKETING",
    "ATTRIBUTION"
  ],
  "brand": {
    "id": "brand_dummy",
    "displayName": "",
  },
  "description": "Tradedoubler server-to-server (S2S) conversion tracking.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "RADIO",
    "name": "type",
    "displayName": "Event Type",
    "radioItems": [
      {
        "value": "pageView",
        "displayValue": "Page View"
      },
      {
        "value": "userData",
        "displayValue": "User Data"
      },
      {
        "value": "conversion",
        "displayValue": "Conversion"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "pageView",
    "help": "\u003cb\u003ePage View\u003c/b\u003e - Stores the \u003ci\u003e{tduid}\u003c/i\u003e or \u003ci\u003edeviceid\u003c/i\u003e URL parameters value inside the \u003ci\u003etduid\u003c/i\u003e cookie; and the \u003ci\u003e{tdclid_sn}\u003c/i\u003e URL parameter value inside the \u003ci\u003etdclid_sn\u003c/i\u003e cookie.\n\u003cbr/\u003e\nFor app conversions, you need to store and retrieve the Click ID using some other method, such as:\n\u003cul\u003e\n\u003cli\u003e\u003ca href\u003d\"https://stape.io/helpdesk/documentation/stape-store-feature#how-to-use-the-stape-store-writer-tag\"\u003eStape Store Writer tag\u003c/a\u003e and \u003ca href\u003d\"https://stape.io/helpdesk/documentation/stape-store-feature#stape-store-lookup-variable\"\u003eStape Store Lookup variable\u003c/a\u003e\u003c/li\u003e\n\u003cli\u003e\u003ca href\u003d\"https://stape.io/blog/write-data-to-firestore-from-server-google-tag-manager\"\u003eFirestore Writer tag\u003c/a\u003e and \u003ca href\u003d\"https://stape.io/solutions/firestore-restore-variable\"\u003eFirestore Restore ariable\u003c/a\u003e\u003c/li\u003e\n\u003c/ul\u003e\n\u003cbr/\u003e\n\u003cbr/\u003e\n\u003cb\u003eConversion\u003c/b\u003e - Sends a postback with conversion data to Tradedoubler.\n\u003cbr/\u003e\n\u003cbr/\u003e\n\u003cb\u003eUser Data\u003c/b\u003e - Sends a request containing User Data (email or User ID). You can use this event if you don\u0027t have User Data available when the conversion happens. \u003ca href\u003d\"https://dev.tradedoubler.com/crossdevice/advertiser/#API\"\u003eLearn more\u003c/a\u003e."
  },
  {
    "type": "TEXT",
    "name": "organizationId",
    "displayName": "Organization ID",
    "simpleValueType": true,
    "help": "Your Organization ID as provided by Tradedoubler.\n\u003cbr\u003e\u003cbr\u003e\nThe Organization ID can be replaced by a Program ID and Publisher site ID combination if required. Your Tradedoubler contact can explain this further.\n\u003cbr\u003e\n\u003cbr\u003e\nYou can get it from Tradedoubler website under \u003ci\u003e\"My Programs\" -\u003e \"Tracking Set-up\" -\u003e \"Tracking Information\"\u003c/i\u003e.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "POSITIVE_NUMBER"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "type",
        "paramValue": "userData",
        "type": "EQUALS"
      },
      {
        "paramName": "type",
        "paramValue": "conversion",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "SELECT",
    "name": "useOptimisticScenario",
    "displayName": "Use Optimistic Scenario",
    "macrosInSelect": true,
    "selectItems": [
      {
        "value": true,
        "displayValue": "true"
      },
      {
        "value": false,
        "displayValue": "false"
      }
    ],
    "simpleValueType": true,
    "help": "The tag will call gtmOnSuccess() without waiting for a response from the API. This will speed up sGTM response time however your tag will always return the status fired successfully even in case it is not.",
    "defaultValue": false,
    "enablingConditions": [
      {
        "paramName": "type",
        "paramValue": "userData",
        "type": "EQUALS"
      },
      {
        "paramName": "type",
        "paramValue": "conversion",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "pageViewGroup",
    "displayName": "",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "tduidClickIdParameterName",
        "displayName": "Name of the URL parameter for the Click ID",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "defaultValue": "tduid",
        "help": "URL Click ID that contains rich information about the click.\n\u003cbr\u003e\u003cbr\u003e\nDefaults to the \u003ci\u003etduid\u003c/i\u003e URL parameter.\n\u003cbr\u003e\nYou usually don’t need to change this, only modify it if you have a custom implementation.",
        "valueHint": "tduid"
      },
      {
        "type": "TEXT",
        "name": "tdclidClickIdParameterName",
        "displayName": "Name of the URL parameter for the Click ID (cashback and loyalty)",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "defaultValue": "tdclid_sn",
        "help": "URL Click ID used by cashback and loyalty publishers.\n\u003cbr\u003e\u003cbr\u003e\nDefaults to the \u003ci\u003etdclid_sn\u003c/i\u003e or \u003ci\u003edeviceid\u003c/i\u003e URL parameters.\n\u003cbr\u003e\nYou usually don’t need to change this, only modify it if you have a custom implementation.",
        "valueHint": "tdclid_sn"
      },
      {
        "type": "GROUP",
        "name": "cookieSettingsGroup",
        "displayName": "Cookie Settings (Web only)",
        "groupStyle": "ZIPPY_OPEN_ON_PARAM",
        "subParams": [
          {
            "type": "TEXT",
            "name": "cookieExpiration",
            "displayName": "Cookie Expiration",
            "simpleValueType": true,
            "help": "The number of days Click ID cookie will live.\n\u003cbr\u003e\u003cbr\u003e\nSet this to, at least, the agreed cookie duration on your program settings.",
            "valueUnit": "days",
            "defaultValue": 365,
            "valueHint": "365",
            "valueValidators": [
              {
                "type": "NON_NEGATIVE_NUMBER"
              }
            ]
          },
          {
            "type": "TEXT",
            "name": "cookieDomain",
            "displayName": "Cookie Domain",
            "simpleValueType": true,
            "help": "Enable this option to override the cookie domain.\n\u003cbr/\u003e\nEnter your website\u0027s top-level domain as a fixed value (e.g., example.com).\n\u003cbr/\u003e\nIf left unchecked, the top-level domain will be automatically determined using the following priority:\n\u003cul\u003e\n\u003cli\u003eTop-level domain of the \u003ci\u003eForwarded\u003c/i\u003e header (if present).\u003c/li\u003e\n\u003cli\u003eTop-level domain of the \u003ci\u003eX-Forwarded-Host\u003c/i\u003e header (if present).\u003c/li\u003e\n\u003cli\u003eTop-level domain of the \u003ci\u003eHost\u003c/i\u003e header.\u003c/li\u003e\n\u003c/ul\u003e",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ],
            "defaultValue": "auto",
            "valueHint": "example.com"
          },
          {
            "type": "SELECT",
            "name": "cookieHttpOnly",
            "displayName": "Http Only Flag",
            "macrosInSelect": true,
            "selectItems": [
              {
                "value": false,
                "displayValue": "False"
              },
              {
                "value": true,
                "displayValue": "True"
              }
            ],
            "simpleValueType": true,
            "defaultValue": false
          }
        ]
      }
    ],
    "enablingConditions": [
      {
        "paramName": "type",
        "paramValue": "pageView",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "userDataGroup",
    "displayName": "User Data",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "SELECT",
        "name": "redactIpAddress",
        "displayName": "Redact Visitor IP Address",
        "macrosInSelect": true,
        "selectItems": [
          {
            "value": true,
            "displayValue": "true"
          },
          {
            "value": false,
            "displayValue": "false"
          }
        ],
        "simpleValueType": true,
        "defaultValue": false,
        "help": "Removes the visitor\u0027s IP address from the request."
      },
      {
        "type": "TEXT",
        "name": "userEmail",
        "displayName": "User Email Address",
        "simpleValueType": true,
        "help": "Required for \u003cb\u003eUser Data event\u003c/b\u003e, if User ID is not set.\n\u003cbr\u003e\nOptional for \u003cb\u003eConversion event\u003c/b\u003e.\n\u003cbr\u003e\n\u003cbr\u003e\nAdd the User Email Address hashed with SHA256 or in plain text to be automatically hashed.\n\u003cbr\u003e\nIf both the User Email Address and the User ID are set, the User Email Address takes precedence.\n\u003cbr\u003e\u003cbr\u003e\nDefault: \u003ci\u003eeventData.email\u003c/i\u003e \u003e \u003ci\u003eeventData.email_address\u003c/i\u003e \u003e \u003ci\u003eeventData.user_data.email\u003c/i\u003e \u003e \u003ci\u003eeventData.user_data.email_address\u003c/i\u003e \u003e \u003ci\u003eeventData.user_data.sha256_email_address\u003c/i\u003e."
      },
      {
        "type": "TEXT",
        "name": "userId",
        "displayName": "User ID",
        "simpleValueType": true,
        "help": "Required for \u003cb\u003eUser Data event\u003c/b\u003e, if User Email Address is not set.\n\u003cbr\u003e\nOptional for \u003cb\u003eConversion event\u003c/b\u003e.\n\u003cbr\u003e\n\u003cbr\u003e\nAdd the User ID hashed with SHA256 or in plain text to be automatically hashed.\u003cbr\u003eIf both the User Email Address and the User ID are set, the User Email Address takes precedence.\n\u003cbr\u003e\u003cbr\u003e\nDefault: \u003ci\u003eeventData.user_id\u003c/i\u003e."
      },
      {
        "type": "TEXT",
        "name": "userDeviceId",
        "displayName": "Device ID",
        "simpleValueType": true,
        "help": "Optional.\n\u003cbr\u003e\n\u003cbr\u003e\nThe Device ID should be included when no cookie is available (i.e. when the user is in-app).\nIf the user is in the web browser (where a Click ID cookie is available) this parameter should be left empty.\n\u003cbr\u003e\u003cbr\u003e\nDefault: \u003ci\u003eeventData.x-ga-resettable_device_id\u003c/i\u003e."
      }
    ],
    "enablingConditions": [
      {
        "paramName": "type",
        "paramValue": "conversion",
        "type": "EQUALS"
      },
      {
        "paramName": "type",
        "paramValue": "userData",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "conversionGroup",
    "displayName": "Conversion Parameters",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "LABEL",
        "name": "parametersOverrideGroupHelpText",
        "displayName": "By default, the tag will parse all available params from the \u003ci\u003eeventData\u003c/i\u003e. Check the Help Texts from the fields below for more details."
      },
      {
        "type": "SELECT",
        "name": "conversionType",
        "displayName": "Conversion Type",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "sales",
            "displayValue": "Sales"
          },
          {
            "value": "leads",
            "displayValue": "Leads"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "sales"
      },
      {
        "type": "TEXT",
        "name": "programId",
        "displayName": "Program ID",
        "simpleValueType": true,
        "help": "The Organization ID can be replaced by a Program ID and Publisher Site ID combination if required. Your Tradedoubler contact can explain this further.\n\u003cbr\u003e\n\u003cbr\u003e\nYou can get it from Tradedoubler website under \u003ci\u003e\"My Programs\" -\u003e \"Tracking Set-up\" -\u003e \"Tracking Information\"\u003c/i\u003e.",
        "valueValidators": [
          {
            "type": "NUMBER"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "eventId",
        "displayName": "Event ID",
        "simpleValueType": true,
        "help": "The Event ID for the lead/sale taking place as provided by Tradedoubler.",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          },
          {
            "type": "POSITIVE_NUMBER"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "tduidClickId",
        "displayName": "tduid Value (Click ID)",
        "simpleValueType": true,
        "help": "If left empty, this value will be automatically taken from the \u003ci\u003etduid\u003c/i\u003e cookie, which is set on pages containing the \u003ci\u003etduid\u003c/i\u003e or \u003ci\u003edeviceid\u003c/i\u003e URL parameters. \u003cbr/\u003eOnly modify it if you have a custom implementation.\n\u003cbr/\u003e\u003cbr/\u003e\nFor app conversions, you need to store and retrieve the Click ID using some other method, such as:\n\u003cul\u003e\n\u003cli\u003e\u003ca href\u003d\"https://stape.io/helpdesk/documentation/stape-store-feature#how-to-use-the-stape-store-writer-tag\"\u003eStape Store Writer tag\u003c/a\u003e and \u003ca href\u003d\"https://stape.io/helpdesk/documentation/stape-store-feature#stape-store-lookup-variable\"\u003eStape Store Lookup variable\u003c/a\u003e\u003c/li\u003e\n\u003cli\u003e\u003ca href\u003d\"https://stape.io/blog/write-data-to-firestore-from-server-google-tag-manager\"\u003eFirestore Writer tag\u003c/a\u003e and \u003ca href\u003d\"https://stape.io/solutions/firestore-restore-variable\"\u003eFirestore Restore ariable\u003c/a\u003e\u003c/li\u003e\n\u003c/ul\u003e"
      },
      {
        "type": "TEXT",
        "name": "tdclidClickId",
        "displayName": "tdclid_sn Value (Click ID for cashback and loyalty publishers)",
        "simpleValueType": true,
        "help": "If left empty, this value will be automatically taken from the \u003ci\u003etdclid_sn\u003c/i\u003e cookie, which is set on pages containing the \u003ci\u003etdclid_sn\u003c/i\u003e URL parameter. \u003cbr/\u003eOnly modify it if you have a custom implementation.\n\u003cbr/\u003e\u003cbr/\u003e\nFor app conversions, you need to store and retrieve the Click ID using some other method, such as:\n\u003cul\u003e\n\u003cli\u003e\u003ca href\u003d\"https://stape.io/helpdesk/documentation/stape-store-feature#how-to-use-the-stape-store-writer-tag\"\u003eStape Store Writer tag\u003c/a\u003e and \u003ca href\u003d\"https://stape.io/helpdesk/documentation/stape-store-feature#stape-store-lookup-variable\"\u003eStape Store Lookup variable\u003c/a\u003e\u003c/li\u003e\n\u003cli\u003e\u003ca href\u003d\"https://stape.io/blog/write-data-to-firestore-from-server-google-tag-manager\"\u003eFirestore Writer tag\u003c/a\u003e and \u003ca href\u003d\"https://stape.io/solutions/firestore-restore-variable\"\u003eFirestore Restore ariable\u003c/a\u003e\u003c/li\u003e\n\u003c/ul\u003e"
      },
      {
        "type": "TEXT",
        "name": "leadOrOrderNumber",
        "displayName": "Lead Number / Order Number",
        "simpleValueType": true,
        "help": "Required.\n\u003cbr\u003e\u003cbr\u003e\nYour unique reference for the transaction/lead taking place. This must be unique for each transaction/lead and should ideally match your internal reference.\n\u003cbr\u003e\u003cbr\u003e\nFor Leads you can simply pass a unique Event ID generated using a GTM custom variable template.\n\u003cbr\u003e\u003cbr\u003e\nDefault: \u003ci\u003eeventData.orderId\u003c/i\u003e \u003e \u003ci\u003eeventData.order_id\u003c/i\u003e \u003e \u003ci\u003eeventData.transaction_id\u003c/i\u003e."
      },
      {
        "type": "TEXT",
        "name": "orderValue",
        "displayName": "Order Value",
        "simpleValueType": true,
        "help": "Required for Sales.\n\u003cbr\u003e\u003cbr\u003e\nThe order value for the transaction. You must decide if you include tax (e.g. VAT) and shipping or just the net order value. No currency symbols (e.g. £) or thousand separators should be included. Only a decimal point can be used as a separator. \n\u003cbr\u003e\u003cbr\u003e\nDefault: \u003ci\u003eeventData.value\u003c/i\u003e."
      },
      {
        "type": "TEXT",
        "name": "currency",
        "displayName": "Currency",
        "simpleValueType": true,
        "help": "Required for Sales.\n\u003cbr\u003e\u003cbr\u003e\nIf you work with multiple currencies you can state the currency used and Tradedoubler will convert the order value to your program\u0027s currency. The value must be a recognised currency code as per \u003ca href\u003d\"http://en.wikipedia.org/wiki/ISO_4217\"\u003eISO-4217 standard\u003c/a\u003e (e.g. EUR, USD, etc.).\t \n\u003cbr\u003e\u003cbr\u003e\nDefault: \u003ci\u003eeventData.currency\u003c/i\u003e \u003e \u003ci\u003eeventData.currencyCode\u003c/i\u003e."
      },
      {
        "type": "TEXT",
        "name": "voucher",
        "displayName": "Voucher",
        "simpleValueType": true,
        "help": "Optional.\n\u003cbr\u003e\u003cbr\u003e\nIf you are using Tradedoubler\u0027s voucher code tracking feature insert the voucher code used on the transaction. See \u003ca href\u003d\"https://dev.tradedoubler.com/tracking/advertiser/#Features_Voucher\"\u003eVoucher Code Tracking for more information\u003c/a\u003e.\n\u003cbr\u003e\u003cbr\u003e\nDefault: \u003ci\u003eeventData.coupon\u003c/i\u003e."
      },
      {
        "type": "GROUP",
        "name": "productsGroup",
        "displayName": "",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "CHECKBOX",
            "name": "enablePLT",
            "checkboxText": "Enable Product Level Tracking (PLT)",
            "simpleValueType": true,
            "help": "Award commission and set up promotional pricing on product level.",
            "enablingConditions": [
              {
                "paramName": "conversionType",
                "paramValue": "sales",
                "type": "EQUALS"
              }
            ]
          },
          {
            "type": "TEXT",
            "name": "products",
            "displayName": "Products",
            "simpleValueType": true,
            "help": "Default: \u003ci\u003eeventData.items\u003c/i\u003e.\n\nIf you \u003cb\u003edo NOT enable the Product Level Tracking (PLT) checkbox\u003c/b\u003e, this parameter allows advertisers to report product data for each transaction. The standard implementation includes Product ID, Product Name, Product Price and Product Quantity purchased. This information is then visible for advertisers and publishers in the standard reports.\n\u003cbr\u003e\u003cbr\u003e\nThe expected format is an array of objects, each object is a product containing the properties \u003ci\u003eitem_id\u003c/i\u003e, \u003ci\u003eitem_name\u003c/i\u003e, \u003ci\u003eprice\u003c/i\u003e and \u003ci\u003equantity\u003c/i\u003e.\n\u003cbr\u003e\u003cbr\u003e\n-\n\u003cbr\u003e\u003cbr\u003e\nIf you \u003cb\u003eenable the Product Level Tracking (PLT) checkbox\u003c/b\u003e, this parameter will allow advertisers to award commission and set up promotional pricing on product level see the \u003ca href\u003d\"https://dev.tradedoubler.com/tracking/advertiser/#PLT\"\u003eProduct Level Tracking section\u003c/a\u003e. The standard implementation includes Product ID, Product Group ID, Product Name, Product Price and Product Quantity purchased.\n\u003cbr\u003e\u003cbr\u003e\nThe expected format is an array of objects, each object is a product containing the properties \u003ci\u003eitem_id\u003c/i\u003e, \u003ci\u003eitem_group_id\u003c/i\u003e, \u003ci\u003eitem_name\u003c/i\u003e, \u003ci\u003eprice\u003c/i\u003e and \u003ci\u003equantity\u003c/i\u003e."
          }
        ],
        "enablingConditions": [
          {
            "paramName": "conversionType",
            "paramValue": "sales",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "eventTime",
        "displayName": "Event Time",
        "simpleValueType": true,
        "help": "Optional.\n\u003cbr\u003e\u003cbr\u003e\nIn case the request is not triggered in real time you can specify the correct event timestamp.\n\u003cbr\u003e\nExpected format (ISO-9075): YYYY-MM-DD hh:mm:ss (e.g. 2025-12-30 22:15:48)"
      },
      {
        "type": "TEXT",
        "name": "validOn",
        "displayName": "Valid On",
        "simpleValueType": true,
        "help": "Optional.\n\u003cbr\u003e\u003cbr\u003e\nThe value must use the format YYYY-MM-DD (as per \u003ca href\u003d\"https://en.wikipedia.org/wiki/ISO_8601\"\u003eISO-8601 standard\u003c/a\u003e). See \u003ca href\u003d\"https://dev.tradedoubler.com/tracking/advertiser/#Features_ValidOn\"\u003eValid On\u003c/a\u003e for more information."
      }
    ],
    "enablingConditions": [
      {
        "paramName": "type",
        "paramValue": "conversion",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "consentSettingsGroup",
    "displayName": "Consent Settings",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "RADIO",
        "name": "adStorageConsent",
        "displayName": "",
        "radioItems": [
          {
            "value": "optional",
            "displayValue": "Send data always"
          },
          {
            "value": "required",
            "displayValue": "Send data in case marketing consent given"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "optional"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "logsGroup",
    "displayName": "Logs Settings",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "RADIO",
        "name": "logType",
        "radioItems": [
          {
            "value": "no",
            "displayValue": "Do not log"
          },
          {
            "value": "debug",
            "displayValue": "Log to console during debug and preview"
          },
          {
            "value": "always",
            "displayValue": "Always log to console"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "debug"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "type",
        "paramValue": "conversion",
        "type": "EQUALS"
      },
      {
        "paramName": "type",
        "paramValue": "userData",
        "type": "EQUALS"
      }
    ]
  },
  {
    "displayName": "BigQuery Logs Settings",
    "name": "bigQueryLogsGroup",
    "groupStyle": "ZIPPY_CLOSED",
    "type": "GROUP",
    "subParams": [
      {
        "type": "RADIO",
        "name": "bigQueryLogType",
        "radioItems": [
          {
            "value": "no",
            "displayValue": "Do not log to BigQuery"
          },
          {
            "value": "always",
            "displayValue": "Log to BigQuery"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "no"
      },
      {
        "type": "GROUP",
        "name": "logsBigQueryConfigGroup",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "TEXT",
            "name": "logBigQueryProjectId",
            "displayName": "BigQuery Project ID",
            "simpleValueType": true,
            "help": "Optional.  \u003cbr/\u003e\u003cbr/\u003e  If omitted, it will be retrieved from the environment variable \u003cI\u003eGOOGLE_CLOUD_PROJECT\u003c/i\u003e where the server container is running. If the server container is running on Google Cloud, \u003cI\u003eGOOGLE_CLOUD_PROJECT\u003c/i\u003e will already be set to the Google Cloud project\u0027s ID."
          },
          {
            "type": "TEXT",
            "name": "logBigQueryDatasetId",
            "displayName": "BigQuery Dataset ID",
            "simpleValueType": true,
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "type": "TEXT",
            "name": "logBigQueryTableId",
            "displayName": "BigQuery Table ID",
            "simpleValueType": true,
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ],
        "enablingConditions": [
          {
            "paramName": "bigQueryLogType",
            "paramValue": "always",
            "type": "EQUALS"
          }
        ]
      }
    ],
    "enablingConditions": [
      {
        "paramName": "type",
        "paramValue": "conversion",
        "type": "EQUALS"
      },
      {
        "paramName": "type",
        "paramValue": "userData",
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

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


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "headerWhitelist",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "trace-id"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "referer"
                  }
                ]
              }
            ]
          }
        },
        {
          "key": "remoteAddressAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "headersAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "tduid"
              },
              {
                "type": 1,
                "string": "tdclid_sn"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "all"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_container_data",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "set_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedCookies",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "tduid"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "tdclid_sn"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_event_data",
        "versionId": "1"
      },
      "param": [
        {
          "key": "eventDataAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_http",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://tbl.tradedoubler.com/"
              },
              {
                "type": 1,
                "string": "https://tbs.tradedoubler.com/"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_bigquery",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedTables",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "projectId"
                  },
                  {
                    "type": 1,
                    "string": "datasetId"
                  },
                  {
                    "type": 1,
                    "string": "tableId"
                  },
                  {
                    "type": 1,
                    "string": "operation"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: PageView - Click ID cookies (tduid and tdclid_sn) are NOT set if URL doesn't
    contain the Click IDs parameters
  code: |
    setAllMockDataByEventType('pageView');

    mock('getAllEventData', {
      page_location: 'https://example.com/'
    });

    runCode(mockData);

    assertApi('gtmOnSuccess').wasCalled();
    assertApi('gtmOnFailure').wasNotCalled();
    assertApi('setCookie').wasNotCalled();
- name: PageView - tduid Click ID cookie is set if URL contains it
  code: |
    setAllMockDataByEventType('pageView');

    const expectedClickId = 'expectedClickId';
    mock('getAllEventData', {
      page_location: 'https://example.com/?utm_source=test&tduid=' + expectedClickId
    });

    runCode(mockData);

    assertApi('gtmOnSuccess').wasCalled();
    assertApi('gtmOnFailure').wasNotCalled();
    assertApi('setCookie').wasCalledWith('tduid', expectedClickId, {
      domain: 'auto',
      samesite: 'Lax',
      path: '/',
      secure: true,
      httpOnly: false,
      'max-age': 31536000
    }, false);
- name: PageView - tdclid_sn Click ID cookie is set if URL contains it
  code: |-
    setAllMockDataByEventType('pageView');

    const expectedClickId = 'expectedClickId';
    mock('getAllEventData', {
      page_location: 'https://example.com/?utm_source=test&tdclid_sn=' + expectedClickId
    });

    runCode(mockData);

    assertApi('gtmOnSuccess').wasCalled();
    assertApi('gtmOnFailure').wasNotCalled();
    assertApi('setCookie').wasCalledWith('tdclid_sn', expectedClickId, {
      domain: 'auto',
      samesite: 'Lax',
      path: '/',
      secure: true,
      httpOnly: false,
      'max-age': 31536000
    }, false);
- name: PageView - Cookies settings are overriden when setting the tduid and tdclid
    Click IDs
  code: |-
    const expectedCookieDomain = 'example.com';
    const expectedCookieExpirationInDays = 90;
    const expectedCookieHttpOnly = true;
    setAllMockDataByEventType('pageView', {
      cookieDomain: expectedCookieDomain,
      cookieExpiration: expectedCookieExpirationInDays,
      cookieHttpOnly: expectedCookieHttpOnly
    });

    const expectedtduidClickId = 'expectedtduidClickId';
    const expectedtdclidClickId = 'expectedtdclidClickId';
    mock('getAllEventData', {
      page_location: 'https://example.com/?utm_source=test&tduid=' + expectedtduidClickId + '&tdclid_sn=' + expectedtdclidClickId
    });

    runCode(mockData);

    assertApi('gtmOnSuccess').wasCalled();
    assertApi('gtmOnFailure').wasNotCalled();
    assertApi('setCookie').wasCalledWith('tduid', expectedtduidClickId, {
      domain: expectedCookieDomain,
      samesite: 'Lax',
      path: '/',
      secure: true,
      httpOnly: expectedCookieHttpOnly,
      'max-age': 60 * 60 * 24 * expectedCookieExpirationInDays
    }, false);
    assertApi('setCookie').wasCalledWith('tdclid_sn', expectedtdclidClickId, {
      domain: expectedCookieDomain,
      samesite: 'Lax',
      path: '/',
      secure: true,
      httpOnly: expectedCookieHttpOnly,
      'max-age': 60 * 60 * 24 * expectedCookieExpirationInDays
    }, false);
- name: User Data - Request is NOT sent if required parameters are missing
  code: "setAllMockDataByEventType('userData');\n\nmock('sendHttpRequest', function()\
    \ {\n  fail('Required parameter is missing. Request should not have been sent.');\n\
    });\n\n[['organizationId'], ['userId', 'userEmail']].forEach(params => {\n  const\
    \ originalMockDataCopy = JSON.parse(JSON.stringify(mockData));\n  \n  params.forEach(p\
    \ => originalMockDataCopy[p] = undefined);\n\n  runCode(originalMockDataCopy);\n\
    \  \n  assertApi('gtmOnFailure').wasCalled();\n  assertApi('gtmOnSuccess').wasNotCalled();\n\
    });"
- name: User Data - IP Address is correctly redacted if option is set
  code: |-
    setAllMockDataByEventType('userData', {
      redactIpAddress: true
    });

    mock('getAllEventData', {
      ip_override: '192.168.0.1'
    });

    mock('sendHttpRequest', (requestUrl, callback, requestOptions, requestBody) => {
      assertThat(requestOptions.headers['X-Forwarded-For']).isUndefined();
      callback(200);
    });

    runCode(mockData);

    assertApi('gtmOnSuccess').wasCalled();
    assertApi('gtmOnFailure').wasNotCalled();
- name: User Data - Request is sent - Data from UI fields fallbacks
  code: "mockData.type = 'userData';\nsetGetAllEventData();\n\nconst expectedRequestBaseUrl\
    \ = 'https://tbs.tradedoubler.com/user';\nconst expectedRequestOptions = { method:\
    \ 'GET', headers: {} };\n\n[\n  { /* userId and userEmail defined on Setup, should\
    \ use userEmail */ \n    expectedQueryParameters: {\n      organization: 'organizationId',\n\
    \      extid: '27c6b8e780cfc293ef0436f7d8421af0bed83caae706734b49f8e95d5295b462',\n\
    \      exttype: '1',\n      convtagtid: '11'\n    } \n  },\n  { \n    mockData:\
    \ { userId: undefined }, \n    expectedQueryParameters: {\n      organization:\
    \ 'organizationId',\n      extid: '27c6b8e780cfc293ef0436f7d8421af0bed83caae706734b49f8e95d5295b462',\n\
    \      exttype: '1',\n      convtagtid: '11'\n    }\n  },\n  { \n    mockData:\
    \ { userEmail: undefined }, \n    expectedQueryParameters: {\n      organization:\
    \ 'organizationId',\n      extid: 'fd14499abf2345243b9d48ce26e77f3e7c0f1117ee62a15c97340411b32c85ee',\n\
    \      exttype: '0',\n      convtagtid: '11'\n    } \n  }\n].forEach(scenario\
    \ => {\n  const originalMockDataCopy = JSON.parse(JSON.stringify(mockData));\n\
    \  \n  mergeObj(originalMockDataCopy, scenario.mockData);\n  \n  mock('sendHttpRequest',\
    \ (requestUrl, callback, requestOptions) => {\n    const parsedRequestUrl = parseUrl(requestUrl);\n\
    \    assertThat(parsedRequestUrl.origin + parsedRequestUrl.pathname).isEqualTo(expectedRequestBaseUrl);\n\
    \    assertThat(parsedRequestUrl.searchParams).isEqualTo(scenario.expectedQueryParameters);\n\
    \    assertThat(callback).isFunction();\n    assertThat(requestOptions).isEqualTo(expectedRequestOptions);\n\
    \    \n    callback(200);\n  });\n\n  runCode(originalMockDataCopy);\n  \n  assertApi('gtmOnSuccess').wasCalled();\n\
    \  assertApi('gtmOnFailure').wasNotCalled();\n});"
- name: User Data - Request is sent - Data from UI fields
  code: "setAllMockDataByEventType('userData');\n\nconst expectedRequestBaseUrl =\
    \ 'https://tbs.tradedoubler.com/user';\nconst expectedRequestOptions = { method:\
    \ 'GET', headers: {} };\n\n[\n  { /* userId and userEmail defined on Setup, should\
    \ use userEmail */ \n    expectedQueryParameters: {\n      organization: 'organizationId',\n\
    \      extid: '27c6b8e780cfc293ef0436f7d8421af0bed83caae706734b49f8e95d5295b462',\n\
    \      exttype: '1',\n      deviceid: 'userDeviceId',\n      convtagtid: '11'\n\
    \    } \n  },\n  { \n    mockData: { userId: undefined }, \n    expectedQueryParameters:\
    \ {\n      organization: 'organizationId',\n      extid: '27c6b8e780cfc293ef0436f7d8421af0bed83caae706734b49f8e95d5295b462',\n\
    \      exttype: '1',\n      deviceid: 'userDeviceId',\n      convtagtid: '11'\n\
    \    }\n  },\n  { \n    mockData: { userEmail: undefined }, \n    expectedQueryParameters:\
    \ {\n      organization: 'organizationId',\n      extid: 'fd14499abf2345243b9d48ce26e77f3e7c0f1117ee62a15c97340411b32c85ee',\n\
    \      exttype: '0',\n      deviceid: 'userDeviceId',\n      convtagtid: '11'\n\
    \    } \n  }\n].forEach(scenario => {\n  const originalMockDataCopy = JSON.parse(JSON.stringify(mockData));\n\
    \  \n  mergeObj(originalMockDataCopy, scenario.mockData);\n  \n  mock('sendHttpRequest',\
    \ (requestUrl, callback, requestOptions) => {\n    const parsedRequestUrl = parseUrl(requestUrl);\n\
    \    assertThat(parsedRequestUrl.origin + parsedRequestUrl.pathname).isEqualTo(expectedRequestBaseUrl);\n\
    \    assertThat(parsedRequestUrl.searchParams).isEqualTo(scenario.expectedQueryParameters);\n\
    \    assertThat(callback).isFunction();\n    assertThat(requestOptions).isEqualTo(expectedRequestOptions);\n\
    \    \n    callback(200);\n  });\n\n  runCode(originalMockDataCopy);\n  \n  assertApi('gtmOnSuccess').wasCalled();\n\
    \  assertApi('gtmOnFailure').wasNotCalled();\n});"
- name: Conversion - IP Address is correctly redacted if option is set
  code: |-
    setAllMockDataByEventType('conversion', {
      redactIpAddress: true
    });

    mock('getAllEventData', {
      ip_override: '192.168.0.1'
    });

    mock('sendHttpRequest', (requestUrl, callback, requestOptions, requestBody) => {
      assertThat(requestOptions.headers['X-Forwarded-For']).isUndefined();
      callback(200);
    });

    runCode(mockData);

    assertApi('gtmOnSuccess').wasCalled();
    assertApi('gtmOnFailure').wasNotCalled();
- name: Conversion - Request is NOT sent if required parameters are missing (Leads)
  code: "setAllMockDataByEventType('conversion', {\n  conversionType: 'leads'\n});\n\
    \nmock('sendHttpRequest', function() {\n  fail('Required parameter is missing.\
    \ Request should not have been sent.');\n});\n\n['organizationId', 'eventId',\
    \ 'leadOrOrderNumber'].forEach(p => {\n  const originalMockDataCopy = JSON.parse(JSON.stringify(mockData));\n\
    \  \n  originalMockDataCopy[p] = undefined;\n  \n  runCode(originalMockDataCopy);\n\
    \  \n  assertApi('gtmOnFailure').wasCalled();\n  assertApi('gtmOnSuccess').wasNotCalled();\n\
    });"
- name: Conversion - Request is sent - Data from UI fields fallbacks (Leads)
  code: "mockData.type = 'conversion';\nmockData.eventId = 'eventId';\nmockData.conversionType\
    \ = 'leads';\n\nsetGetAllEventData({\n  transaction_id: 'transaction_id'\n});\n\
    \nconst expectedRequestBaseUrl = 'https://tbl.tradedoubler.com/report';\nconst\
    \ expectedRequestOptions = { method: 'GET', headers: {} };\nconst expectedQueryParameters\
    \ = {\n  organization: 'organizationId',\n  event: 'eventId',\n  ordervalue: '123.45',\n\
    \  leadnumber: 'transaction_id',\n  currency: 'BRL',\n  voucher: 'coupon',\n \
    \ extid: '27c6b8e780cfc293ef0436f7d8421af0bed83caae706734b49f8e95d5295b462',\n\
    \  exttype: '1',\n  convtagtid: '11'\n};\n\nmock('sendHttpRequest', (requestUrl,\
    \ callback, requestOptions) => {\n  const parsedRequestUrl = parseUrl(requestUrl);\n\
    \  assertThat(parsedRequestUrl.origin + parsedRequestUrl.pathname).isEqualTo(expectedRequestBaseUrl);\n\
    \  assertThat(parsedRequestUrl.searchParams).isEqualTo(expectedQueryParameters);\n\
    \  assertThat(callback).isFunction();\n  assertThat(requestOptions).isEqualTo(expectedRequestOptions);\n\
    \  \n  callback(200);\n});\n\nrunCode(mockData);\n\nassertApi('gtmOnSuccess').wasCalled();\n\
    assertApi('gtmOnFailure').wasNotCalled();"
- name: Conversion - Request is sent - Data from UI fields (Leads)
  code: "setAllMockDataByEventType('conversion', {\n  conversionType: 'leads',\n \
    \ products: undefined\n});\n\nconst expectedRequestBaseUrl = 'https://tbl.tradedoubler.com/report';\n\
    const expectedRequestOptions = { method: 'GET', headers: {} };\nconst expectedQueryParameters\
    \ = {\n  organization: 'organizationId',\n  program: 'programId',\n  event: 'eventId',\n\
    \  ordervalue: 'orderValue',\n  leadnumber: 'leadOrOrderNumber',\n  tduid: 'tduidClickId',\n\
    \  tdclid: 'tdclidClickId',\n  currency: 'currency',\n  voucher: 'voucher',\n\
    \  event_time: '2025-06-03 12:12:12',\n  validOn: '2025-06-10',\n  extid: '27c6b8e780cfc293ef0436f7d8421af0bed83caae706734b49f8e95d5295b462',\n\
    \  exttype: '1',\n  deviceid: 'userDeviceId',\n  convtagtid: '11'\n};\n\nmock('sendHttpRequest',\
    \ (requestUrl, callback, requestOptions) => {\n  const parsedRequestUrl = parseUrl(requestUrl);\n\
    \  assertThat(parsedRequestUrl.origin + parsedRequestUrl.pathname).isEqualTo(expectedRequestBaseUrl);\n\
    \  assertThat(parsedRequestUrl.searchParams).isEqualTo(expectedQueryParameters);\n\
    \  assertThat(callback).isFunction();\n  assertThat(requestOptions).isEqualTo(expectedRequestOptions);\n\
    \  \n  callback(200);\n});\n\nrunCode(mockData);\n\nassertApi('gtmOnSuccess').wasCalled();\n\
    assertApi('gtmOnFailure').wasNotCalled();"
- name: Conversion - Request is NOT sent if required parameters are missing (Sales)
  code: "setAllMockDataByEventType('conversion', {\n  conversionType: 'sales'\n});\n\
    \nmock('sendHttpRequest', function() {\n  fail('Required parameter is missing.\
    \ Request should not have been sent.');\n});\n\n[\n  { organizationId: undefined\
    \ },\n  { eventId: undefined },\n  { leadOrOrderNumber: undefined },\n  { orderValue:\
    \ undefined, enablePLT: false },\n  { products: undefined, enablePLT: true },\n\
    \  { products: [{ item_id: 'a', item_name: 'b', item_group_id: 'c', price: 1,\
    \ quantity: undefined  }], enablePLT: true },\n  { products: [{ item_id: 'a',\
    \ item_name: 'b', item_group_id: 'c', price: undefined, quantity: 1  }], enablePLT:\
    \ true },\n  { products: [{ item_id: 'a', item_name: 'b', item_group_id: undefined,\
    \ price: 1, quantity: 1  }], enablePLT: true },\n  { products: [{ item_id: 'a',\
    \ item_name: undefined, item_group_id: 'c', price: 1, quantity: 1  }], enablePLT:\
    \ true },\n  { products: [{ item_id: undefined, item_name: 'b', item_group_id:\
    \ 'c', price: 1, quantity: 1  }], enablePLT: true },\n].forEach(mergeMockData\
    \ => {\n  const originalMockDataCopy = JSON.parse(JSON.stringify(mockData));\n\
    \  \n  for (const key in mergeMockData) {\n    originalMockDataCopy[key] = mergeMockData[key];\n\
    \  }\n  \n  runCode(originalMockDataCopy);\n  \n  assertApi('gtmOnFailure').wasCalled();\n\
    \  assertApi('gtmOnSuccess').wasNotCalled();\n});"
- name: Conversion - Request is sent - Data from UI fields fallbacks - PLT Disabled
    (Sales)
  code: "mockData.type = 'conversion';\nmockData.eventId = 'eventId';\nmockData.conversionType\
    \ = 'sales';\nmockData.enablePLT = false;\n\nmock('getCookieValues', (cookieName)\
    \ => {\n  if (cookieName === 'tduid') return ['tduidClickId'];\n  else if (cookieName\
    \ === 'tdclid_sn') return ['tdclidClickId'];\n  return [];\n});\n\n\nsetGetAllEventData({\n\
    \  transaction_id: 'transaction_id',\n  items: [\n    {\n      item_id: 'SKU_12345',\n\
    \      item_name: 'Stan and Friends Tee',\n      affiliation: 'Google Merchandise\
    \ Store',\n      coupon: 'SUMMER_FUN',\n      discount: 2.22,\n      index: 0,\n\
    \      item_brand: 'Google',\n      item_category: 'Apparel|iajsdiajsd|oasodiasd',\n\
    \      item_list_id: 'related_products',\n      item_list_name: 'Related Products',\n\
    \      item_variant: 'green',\n      location_id: 'ChIJIQBpAG2ahYAR_6128GcTUEo',\n\
    \      price: 10.01,\n      quantity: 3,\n      item_group_id: 'abc'\n    },\n\
    \    {\n      item_id: 'SKU_12346',\n      item_name: \"Google Grey Women's (Tee)\"\
    ,\n      affiliation: 'Google Merchandise Store',\n      coupon: 'SUMMER_FUN',\n\
    \      discount: 3.33,\n      index: 1,\n      item_brand: 'Google',\n      item_category:\
    \ 'Apparel|iajsdiajsd|oasodiasd',\n      item_list_id: 'related_products',\n \
    \     item_list_name: 'Related Products',\n      item_variant: 'gray',\n     \
    \ location_id: 'ChIJIQBpAG2ahYAR_6128GcTUEo',\n      price: 21.01,\n      promotion_id:\
    \ 'P_12345',\n      promotion_name: 'Summer Sale',\n      quantity: 2,\n     \
    \ item_group_id: 'xyz'\n    }\n  ]\n});\n\nconst expectedRequestBaseUrl = 'https://tbs.tradedoubler.com/report';\n\
    const expectedRequestOptions = { method: 'GET', headers: {} };\nconst expectedQueryParameters\
    \ = {\n  organization: 'organizationId',\n  event: 'eventId',\n  ordervalue: '123.45',\n\
    \  ordernumber: 'transaction_id',\n  currency: 'BRL',\n  voucher: 'coupon',\n\
    \  extid: '27c6b8e780cfc293ef0436f7d8421af0bed83caae706734b49f8e95d5295b462',\n\
    \  exttype: '1',\n  tduid: 'tduidClickId',\n  tdclid: 'tdclidClickId',\n  convtagtid:\
    \ '11',\n  reportInfo: \"f1=SKU_12345&f2=Stan and Friends Tee&f3=10.01&f4=3|f1=SKU_12346&f2=Google\
    \ Grey Women's (Tee)&f3=21.01&f4=2\"\n};\n\nmock('sendHttpRequest', (requestUrl,\
    \ callback, requestOptions) => {\n  const parsedRequestUrl = parseUrl(requestUrl);\n\
    \  assertThat(parsedRequestUrl.origin + parsedRequestUrl.pathname).isEqualTo(expectedRequestBaseUrl);\n\
    \  assertThat(parsedRequestUrl.searchParams).isEqualTo(expectedQueryParameters);\n\
    \  const reportInfoIsLastParameter = !!requestUrl.split('&reportInfo=')[1];\n\
    \  assertThat(reportInfoIsLastParameter, 'reportInfo must be the last parameter').isTrue();\n\
    \  assertThat(callback).isFunction();\n  assertThat(requestOptions).isEqualTo(expectedRequestOptions);\n\
    \  \n  callback(200);\n});\n\nrunCode(mockData);\n\nassertApi('gtmOnSuccess').wasCalled();\n\
    assertApi('gtmOnFailure').wasNotCalled();"
- name: Conversion - Request is sent - Data from UI fields fallbacks - PLT Enabled
    (Sales)
  code: "mockData.type = 'conversion';\nmockData.eventId = 'eventId';\nmockData.conversionType\
    \ = 'sales';\nmockData.enablePLT = true;\n\nmock('getCookieValues', (cookieName)\
    \ => {\n  if (cookieName === 'tduid') return ['tduidClickId'];\n  else if (cookieName\
    \ === 'tdclid_sn') return ['tdclidClickId'];\n  return [];\n});\n\nsetGetAllEventData({\n\
    \  transaction_id: 'transaction_id',\n  items: [\n    {\n      item_id: 'SKU_12345',\n\
    \      item_name: 'Stan and Friends Tee',\n      affiliation: 'Google Merchandise\
    \ Store',\n      coupon: 'SUMMER_FUN',\n      discount: 2.22,\n      index: 0,\n\
    \      item_brand: 'Google',\n      item_category: 'Apparel|iajsdiajsd|oasodiasd',\n\
    \      item_list_id: 'related_products',\n      item_list_name: 'Related Products',\n\
    \      item_variant: 'green',\n      location_id: 'ChIJIQBpAG2ahYAR_6128GcTUEo',\n\
    \      price: 10.01,\n      quantity: 3,\n      item_group_id: 'abc'\n    },\n\
    \    {\n      item_id: 'SKU_12346',\n      item_name: \"Google Grey Women's (Tee)\"\
    ,\n      affiliation: 'Google Merchandise Store',\n      coupon: 'SUMMER_FUN',\n\
    \      discount: 3.33,\n      index: 1,\n      item_brand: 'Google',\n      item_category:\
    \ 'Apparel|iajsdiajsd|oasodiasd',\n      item_list_id: 'related_products',\n \
    \     item_list_name: 'Related Products',\n      item_variant: 'gray',\n     \
    \ location_id: 'ChIJIQBpAG2ahYAR_6128GcTUEo',\n      price: 21.01,\n      promotion_id:\
    \ 'P_12345',\n      promotion_name: 'Summer Sale',\n      quantity: 2,\n     \
    \ item_group_id: 'xyz'\n    }\n  ]\n});\n\nconst expectedRequestBaseUrl = 'https://tbs.tradedoubler.com/report';\n\
    const expectedRequestOptions = { method: 'GET', headers: {} };\n\nmock('sendHttpRequest',\
    \ (requestUrl, callback, requestOptions) => {\n  const parsedRequestUrl = parseUrl(requestUrl);\n\
    \  assertThat(parsedRequestUrl.origin + parsedRequestUrl.pathname).isEqualTo(expectedRequestBaseUrl);\n\
    \  assertThat(parsedRequestUrl.search).isEqualTo(\"?o(organizationId)convtagtid(11)event(eventId)ordervalue(123.45)ordnum(transaction_id)tduid(tduidClickId)tdclid(tdclidClickId)curr(BRL)voucher(coupon)basket(pr(i(SKU_12345)n(Stan%20and%20Friends%20Tee)gr(abc)v(10.01)q(3))pr(i(SKU_12346)n(Google%20Grey%20Women%27s%20)gr(xyz)v(21.01)q(2)))enc(3)extid(27c6b8e780cfc293ef0436f7d8421af0bed83caae706734b49f8e95d5295b462)exttype(1)\"\
    );\n  assertThat(callback).isFunction();\n  assertThat(requestOptions).isEqualTo(expectedRequestOptions);\n\
    \  \n  callback(200);\n});\n\nrunCode(mockData);\n\nassertApi('gtmOnSuccess').wasCalled();\n\
    assertApi('gtmOnFailure').wasNotCalled();"
- name: Conversion - Request is sent - Data from UI fields - PLT Disabled (Sales)
  code: "setAllMockDataByEventType('conversion', {\n  conversionType: 'sales',\n \
    \ enablePLT: false\n});\n\nconst expectedRequestBaseUrl = 'https://tbs.tradedoubler.com/report';\n\
    const expectedRequestOptions = { method: 'GET', headers: {} };\nconst expectedQueryParameters\
    \ = {\n  organization: 'organizationId',\n  program: 'programId',\n  event: 'eventId',\n\
    \  ordervalue: 'orderValue',\n  ordernumber: 'leadOrOrderNumber',\n  tduid: 'tduidClickId',\n\
    \  tdclid: 'tdclidClickId',\n  currency: 'currency',\n  voucher: 'voucher',\n\
    \  event_time: '2025-06-03 12:12:12',\n  validOn: '2025-06-10',\n  extid: '27c6b8e780cfc293ef0436f7d8421af0bed83caae706734b49f8e95d5295b462',\n\
    \  exttype: '1',\n  deviceid: 'userDeviceId',\n  convtagtid: '11',\n  reportInfo:\
    \ \"f1=SKU_12345&f2=Stan and Friends Tee&f3=10.01&f4=3|f1=SKU_12346&f2=Google\
    \ Grey Women's (Tee)&f3=21.01&f4=2\"\n};\n\nmock('sendHttpRequest', (requestUrl,\
    \ callback, requestOptions) => {\n  const parsedRequestUrl = parseUrl(requestUrl);\n\
    \  assertThat(parsedRequestUrl.origin + parsedRequestUrl.pathname).isEqualTo(expectedRequestBaseUrl);\n\
    \  assertThat(parsedRequestUrl.searchParams).isEqualTo(expectedQueryParameters);\n\
    \  const reportInfoIsLastParameter = !!requestUrl.split('&reportInfo=')[1];\n\
    \  assertThat(reportInfoIsLastParameter, 'reportInfo must be the last parameter').isTrue();\n\
    \  assertThat(callback).isFunction();\n  assertThat(requestOptions).isEqualTo(expectedRequestOptions);\n\
    \  \n  callback(200);\n});\n\nrunCode(mockData);\n\nassertApi('gtmOnSuccess').wasCalled();\n\
    assertApi('gtmOnFailure').wasNotCalled();"
- name: Conversion - Request is sent - Data from UI fields - PLT Enabled (Sales)
  code: "setAllMockDataByEventType('conversion', {\n  conversionType: 'sales',\n \
    \ enablePLT: true,\n  products: [\n    {\n      item_id: 'SKU_12345',\n      item_name:\
    \ 'Stan and Friends Tee',\n      affiliation: 'Google Merchandise Store',\n  \
    \    coupon: 'SUMMER_FUN',\n      discount: 2.22,\n      index: 0,\n      item_brand:\
    \ 'Google',\n      item_category: 'Apparel|iajsdiajsd|oasodiasd',\n      item_list_id:\
    \ 'related_products',\n      item_list_name: 'Related Products',\n      item_variant:\
    \ 'green',\n      location_id: 'ChIJIQBpAG2ahYAR_6128GcTUEo',\n      price: 10.01,\n\
    \      quantity: 3,\n      item_group_id: 'abc'\n    },\n    {\n      item_id:\
    \ 'SKU_12346',\n      item_name: \"Google Grey Women's (Tee)\",\n      affiliation:\
    \ 'Google Merchandise Store',\n      coupon: 'SUMMER_FUN',\n      discount: 3.33,\n\
    \      index: 1,\n      item_brand: 'Google',\n      item_category: 'Apparel|iajsdiajsd|oasodiasd',\n\
    \      item_list_id: 'related_products',\n      item_list_name: 'Related Products',\n\
    \      item_variant: 'gray',\n      location_id: 'ChIJIQBpAG2ahYAR_6128GcTUEo',\n\
    \      price: 21.01,\n      promotion_id: 'P_12345',\n      promotion_name: 'Summer\
    \ Sale',\n      quantity: 2,\n      item_group_id: 'xyz'\n    }\n  ]\n});\n\n\
    const expectedRequestBaseUrl = 'https://tbs.tradedoubler.com/report';\nconst expectedRequestOptions\
    \ = { method: 'GET', headers: {} };\n\nmock('sendHttpRequest', (requestUrl, callback,\
    \ requestOptions) => {\n  const parsedRequestUrl = parseUrl(requestUrl);\n  assertThat(parsedRequestUrl.origin\
    \ + parsedRequestUrl.pathname).isEqualTo(expectedRequestBaseUrl);\n  assertThat(parsedRequestUrl.search).isEqualTo(\"\
    ?o(organizationId)convtagtid(11)p(programId)event(eventId)ordervalue(orderValue)ordnum(leadOrOrderNumber)tduid(tduidClickId)tdclid(tdclidClickId)curr(currency)voucher(voucher)event_time(2025-06-03%2012%3A12%3A12)basket(pr(i(SKU_12345)n(Stan%20and%20Friends%20Tee)gr(abc)v(10.01)q(3))pr(i(SKU_12346)n(Google%20Grey%20Women%27s%20)gr(xyz)v(21.01)q(2)))enc(3)extid(27c6b8e780cfc293ef0436f7d8421af0bed83caae706734b49f8e95d5295b462)exttype(1)deviceid(userDeviceId)\"\
    );\n  assertThat(callback).isFunction();\n  assertThat(requestOptions).isEqualTo(expectedRequestOptions);\n\
    \  \n  callback(200);\n});\n\nrunCode(mockData);\n\nassertApi('gtmOnSuccess').wasCalled();\n\
    assertApi('gtmOnFailure').wasNotCalled();"
- name: Should log to console, if the 'Always log to console' option is selected
  code: "setAllMockDataByEventType('conversion', {\n  logType: 'always'\n});\n\nconst\
    \ expectedDebugMode = true;\nmock('getContainerVersion', () => {\n  return {\n\
    \    debugMode: expectedDebugMode\n  };\n}); \n\nmock('logToConsole', (logData)\
    \ => {\n  const parsedLogData = JSON.parse(logData);\n  requiredConsoleKeys.forEach(p\
    \ => assertThat(parsedLogData[p]).isDefined());\n});\n\nmock('sendHttpRequest',\
    \ (requestUrl, callback, requestOptions) => {\n  callback(200);\n});\n\nrunCode(mockData);\n\
    \nassertApi('logToConsole').wasCalled();\nassertApi('gtmOnSuccess').wasCalled();\n\
    assertApi('gtmOnFailure').wasNotCalled();"
- name: Should log to console, if the 'Log during debug and preview' option is selected
    AND is on preview mode
  code: |-
    setAllMockDataByEventType('conversion', {
      logType: 'debug'
    });

    const expectedDebugMode = true;
    mock('getContainerVersion', () => {
      return {
        debugMode: expectedDebugMode
      };
    });

    mock('logToConsole', (logData) => {
      const parsedLogData = JSON.parse(logData);
      requiredConsoleKeys.forEach(p => assertThat(parsedLogData[p]).isDefined());
    });

    mock('sendHttpRequest', (requestUrl, callback, requestOptions, requestBody) => {
      callback(200);
    });

    runCode(mockData);

    assertApi('logToConsole').wasCalled();
    assertApi('gtmOnSuccess').wasCalled();
    assertApi('gtmOnFailure').wasNotCalled();
- name: Should NOT log to console, if the 'Log during debug and preview' option is
    selected AND is NOT on preview mode
  code: "setAllMockDataByEventType('conversion', {\n  logType: 'debug'\n});\n\nconst\
    \ expectedDebugMode = false;\nmock('getContainerVersion', () => {\n  return {\n\
    \    debugMode: expectedDebugMode\n  };\n}); \n\nmock('sendHttpRequest', (requestUrl,\
    \ callback, requestOptions, requestBody) => {\n  callback(200);\n});\n\nrunCode(mockData);\n\
    \nassertApi('logToConsole').wasNotCalled();\nassertApi('gtmOnSuccess').wasCalled();\n\
    assertApi('gtmOnFailure').wasNotCalled();"
- name: Should NOT log to console, if the 'Do not log' option is selected
  code: |-
    setAllMockDataByEventType('conversion', {
      logType: 'no'
    });

    mock('sendHttpRequest', (requestUrl, callback, requestOptions, requestBody) => {
      callback(200);
    });

    runCode(mockData);

    assertApi('logToConsole').wasNotCalled();
    assertApi('gtmOnSuccess').wasCalled();
    assertApi('gtmOnFailure').wasNotCalled();
- name: Should log to BQ, if the 'Log to BigQuery' option is selected
  code: "setAllMockDataByEventType('conversion', {\n  bigQueryLogType: 'always'\n\
    });\n\n// assertApi doesn't work for 'BigQuery.insert()'.\n// Ref: https://gtm-gear.com/posts/gtm-templates-testing/\n\
    mock('BigQuery', () => {\n  return { \n    insert: (connectionInfo, rows, options)\
    \ => { \n      assertThat(connectionInfo).isDefined();\n      assertThat(rows).isArray();\n\
    \      assertThat(rows).hasLength(1);\n      requiredBqKeys.forEach(p => assertThat(rows[0][p]).isDefined());\n\
    \      assertThat(options).isEqualTo(expectedBqOptions);\n      return Promise.create((resolve,\
    \ reject) => {\n        resolve();\n      });\n    }\n  };\n});\n\nmock('sendHttpRequest',\
    \ (requestUrl, callback, requestOptions, requestBody) => {\n  callback(200, {},\
    \ JSON.stringify({ success: true }));\n});\n\nrunCode(mockData);\n\nassertApi('gtmOnSuccess').wasCalled();\n\
    assertApi('gtmOnFailure').wasNotCalled();"
- name: Should NOT log to BQ, if the 'Do not log to BigQuery' option is selected
  code: "setAllMockDataByEventType('conversion', {\n  bigQueryLogType: 'no'\n});\n\
    \n// assertApi doesn't work for 'BigQuery.insert()'.\n// Ref: https://gtm-gear.com/posts/gtm-templates-testing/\n\
    mock('BigQuery', () => {\n  return { \n    insert: (connectionInfo, rows, options)\
    \ => { \n      fail('BigQuery.insert should not have been called.');\n      return\
    \ Promise.create((resolve, reject) => {\n        resolve();\n      });\n    }\n\
    \  };\n});\n\nmock('sendHttpRequest', (requestUrl, callback, requestOptions, requestBody)\
    \ => {\n  callback(200, {}, JSON.stringify({ success: true }));\n});\n\nrunCode(mockData);\n\
    \nassertApi('gtmOnSuccess').wasCalled();\nassertApi('gtmOnFailure').wasNotCalled();"
setup: "const JSON = require('JSON');\nconst Promise = require('Promise');\nconst\
  \ parseUrl = require('parseUrl');\n\nfunction mergeObj(target, source) {\n  for\
  \ (const key in source) {\n    if (source.hasOwnProperty(key)) target[key] = source[key];\n\
  \  }\n  return target;\n}\n\nconst setGetAllEventData = (objToBeMerged) => {\n \
  \ mock('getAllEventData', mergeObj({\n    'x-ga-protocol_version': '2',\n    'x-ga-measurement_id':\
  \ 'G-123ABC',\n    'x-ga-gtm_version': '45je55e1za200',\n    'x-ga-page_id': 1747422523211,\n\
  \    'x-ga-gcd': '13l3l3l3l1l1',\n    'x-ga-npa': '0',\n    'x-ga-dma': '0',\n \
  \   'x-ga-mp2-tag_exp':\n      '101509157~103116025~103130498~103130500~103136993~103136995~103200001~103207802~103211513~103233427~103252644~103252646~103263073~103301114~103301116',\n\
  \    client_id: 'AUJctU7H7hBB/aMuhE4pKwGu5DWDdklg5abyyyn8i/I=.1747154479',\n   \
  \ 'x-ga-ecid': '1294673677',\n    language: 'en-us',\n    screen_resolution: '1512x982',\n\
  \    event_location: { country: 'BR', region: 'SP' },\n    event_id: '101509157~103116025~103130498',\n\
  \    timestamp: 1748377016,\n    client_hints: {\n      architecture: 'arm',\n \
  \     bitness: '64',\n      full_version_list: [\n        { brand: 'Chromium', version:\
  \ '136.0.7103.93' },\n        { brand: 'Google Chrome', version: '136.0.7103.93'\
  \ },\n        { brand: 'Not.A/Brand', version: '99.0.0.0' }\n      ],\n      mobile:\
  \ false,\n      model: '',\n      platform: 'macOS',\n      platform_version: '15.2.0',\n\
  \      wow64: false,\n      brands: [\n        { brand: 'Chromium', version: '136'\
  \ },\n        { brand: 'Google Chrome', version: '136' },\n        { brand: 'Not.A/Brand',\
  \ version: '99' }\n      ]\n    },\n    'x-ga-are': '1',\n    'x-ga-mp2-frm': '0',\n\
  \    'x-ga-pscdl': 'noapi',\n    'x-ga-system_properties': { eu: [34], tu: 'BA',\
  \ ss: '1', ee: true },\n    'x-sst-system_properties': {\n      etld: 'google.com.br',\n\
  \      tft: '1747422523211',\n      lpc: '60493049',\n      navt: 'r',\n      ude:\
  \ '0',\n      sw_exp: '1',\n      request_start_time_ms: 1747422524851\n    },\n\
  \    'x-ga-request_count': 1,\n    ga_session_id: '1747422523',\n    ga_session_number:\
  \ 3,\n    'x-ga-mp2-seg': '0',\n    page_location: 'https://example.com/?test=1i23i21j3',\n\
  \    page_title: 'Example Domain',\n    event_name: 'page_view',\n    'x-ga-tfd':\
  \ 5784,\n    ip_override: '2804:14d:c096:8dd6:311c:8c00:e6c:e33',\n    user_agent:\n\
  \      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML,\
  \ like Gecko) Chrome/136.0.0.0 Safari/537.36',\n    value: 123.45,\n    currency:\
  \ 'BRL',\n    user_id: 'userId',\n    user_data: {\n      email: { 0: 'userEmail',\
  \ 1: 'test2@example.net' },\n      phone_number: '+55 (19) 99999-9999'\n    },\n\
  \    coupon: 'coupon'\n  }, objToBeMerged || {}));\n};\n\nconst expectedBigQuerySettings\
  \ = {\n  logBigQueryProjectId: 'logBigQueryProjectId',\n  logBigQueryDatasetId:\
  \ 'logBigQueryDatasetId',\n  logBigQueryTableId: 'logBigQueryTableId'\n};\n\nconst\
  \ requiredConsoleKeys = ['Type', 'TraceId', 'Name'];\nconst requiredBqKeys = ['timestamp',\
  \ 'type', 'trace_id', 'tag_name'];\nconst expectedBqOptions = { ignoreUnknownValues:\
  \ true };\n\nconst mockData = {\n  organizationId: 'organizationId',\n  useOptimisticScenario:\
  \ false,\n  redactIpAddress: true,\n  logBigQueryProjectId: expectedBigQuerySettings.logBigQueryProjectId,\n\
  \  logBigQueryDatasetId: expectedBigQuerySettings.logBigQueryDatasetId,\n  logBigQueryTableId:\
  \ expectedBigQuerySettings.logBigQueryTableId\n};\n\nconst setAllMockDataByEventType\
  \ = (type, objToBeMerged) => {\n  const mockDataByEventType = {\n    pageView: {\n\
  \      type: 'pageView',\n      tduidClickIdParameterName: 'tduid',\n      tdclidClickIdParameterName:\
  \ 'tdclid_sn',\n      cookieDomain: 'auto',\n      cookieExpiration: 365,\n    \
  \  cookieHttpOnly: false\n    },\n    userData: {\n      type: 'userData',\n   \
  \   redactIpAddress: false,\n      userId: 'userId',\n      userEmail: 'userEmail',\n\
  \      userDeviceId: 'userDeviceId'\n    },\n    conversion: {\n      type: 'conversion',\n\
  \      redactIpAddress: false,\n      userId: 'userId',\n      userEmail: 'userEmail',\n\
  \      userDeviceId: 'userDeviceId',\n      conversionType: 'sales',\n      programId:\
  \ 'programId',\n      eventId: 'eventId',\n      tduidClickId: 'tduidClickId',\n\
  \      tdclidClickId: 'tdclidClickId',\n      leadOrOrderNumber: 'leadOrOrderNumber',\n\
  \      orderValue: 'orderValue',\n      currency: 'currency',\n      voucher: 'voucher',\n\
  \      eventTime: '2025-06-03 12:12:12',\n      validOn: '2025-06-10',\n      enablePLT:\
  \ false,\n      products: [\n        {\n          item_id: 'SKU_12345',\n      \
  \    item_name: 'Stan and Friends Tee',\n          affiliation: 'Google Merchandise\
  \ Store',\n          coupon: 'SUMMER_FUN',\n          discount: 2.22,\n        \
  \  index: 0,\n          item_brand: 'Google',\n          item_category: 'Apparel|iajsdiajsd|oasodiasd',\n\
  \          item_list_id: 'related_products',\n          item_list_name: 'Related\
  \ Products',\n          item_variant: 'green',\n          location_id: 'ChIJIQBpAG2ahYAR_6128GcTUEo',\n\
  \          price: 10.01,\n          quantity: 3,\n          item_group_id: 'abc'\n\
  \        },\n        {\n          item_id: 'SKU_12346',\n          item_name: \"\
  Google Grey Women's (Tee)\",\n          affiliation: 'Google Merchandise Store',\n\
  \          coupon: 'SUMMER_FUN',\n          discount: 3.33,\n          index: 1,\n\
  \          item_brand: 'Google',\n          item_category: 'Apparel|iajsdiajsd|oasodiasd',\n\
  \          item_list_id: 'related_products',\n          item_list_name: 'Related\
  \ Products',\n          item_variant: 'gray',\n          location_id: 'ChIJIQBpAG2ahYAR_6128GcTUEo',\n\
  \          price: 21.01,\n          promotion_id: 'P_12345',\n          promotion_name:\
  \ 'Summer Sale',\n          quantity: 2,\n          item_group_id: 'xyz'\n     \
  \   }\n      ]\n    }\n  };\n  \n  mergeObj(mockDataByEventType[type], objToBeMerged\
  \ || {});\n  mergeObj(mockData, mockDataByEventType[type]);\n};\n\nmock('getRequestHeader',\
  \ (header) => {\n  if (header === 'trace-id') return 'expectedTraceId';\n});\n\n\
  mock('getTimestampMillis', 1747945830456);"


___NOTES___

Created on 6/4/2025, 11:25:14 AM

