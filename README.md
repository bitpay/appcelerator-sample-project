## BitPay Sample Appcelerator App

This app requires the following

* A BitPay merchant account ([Test](http://test.bitpay.com) or [Production](http://www.bitpay.com))
* An API Token ([Test](https://test.bitpay.com/dashboard/merchant/api-tokens) or [Production](https://bitpay.com/dashboard/merchant/api-tokens)

When initializing the module, you must pass ***dev*** or ***production*** so the module can read the values from the **tiapp.xml** file .

# tiapp.xml configuration

The following parameters are used by the module.

```
<property name="bitpayapidev" type="string">https://test.bitpay.com</property>
<property name="bitpayapiprod" type="string">https://www.bitpay.com</property>
<property name="bitpayapikeydev" type="string"><your api key></property>
<property name="bitpayapikeyprod" type="string"><your api key></property>
<property name="bitpaycurrency" type="string"><currency to use></property>
```

The module **must** used the following paramter names (you can add your custom ones as needed)

```
var item = {
        'sku': '<sku>',
        'description': <product description>,
        'price': parseFloat(<price of item>),
    }
```

# Module Usage

Add **bitpay.js** to your **lib** folder

Include and initialize, setting **ENV** to *dev* or *prod*

```
var BitPay = require('lib/bitpay');
BitPay.configure({
    ENV: 'dev'
})
```

Use the button logic starting at line 134 and pass to the *doCheckout* function (or create your own)

Modify the text/buttons as needed.

# This is a sample app, feel free to fork and submit suggestions/PR requests



