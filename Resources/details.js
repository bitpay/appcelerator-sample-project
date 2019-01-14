var win;
var BitPay = require('bitpay');



BitPay.configure()

exports.getMain = function (obj) {
    win = Titanium.UI.createWindow({
        backgroundColor: '#fff',
        layout: 'vertical',
        obj:obj
    });

    var headerView = Titanium.UI.createView({
        top: 0,
        left: 0,
        right: 0,
        height: 60,
        backgroundColor: '#2C418B'
    })
    win.add(headerView)

    var closeLbl = Titanium.UI.createLabel({
        top: 25,
        left: 10,
        color: '#fff',
        text: '<',
        font: {
            fontSize: 18,
            fontWeight: 'bold'
        }
    })
    headerView.add(closeLbl)
    closeLbl.addEventListener('click', function () {
        win.close()
    });

    var headerLbl = Titanium.UI.createLabel({
        top: 25,
        color: '#fff',
        font: {
            fontSize: 18,
            fontWeight: 'bold'
        },
        text:obj.header
    })
    headerView.add(headerLbl)

    var scrollView = Titanium.UI.createScrollView({
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        contentWidth: 'auto',
        contentHeight: 'auto',
        layout: 'vertical'
    })
    win.add(scrollView)

    var img = Titanium.UI.createImageView({
        top: 20,
        width: '60%',
        height: 'auto',
        image: obj.image
    })
    scrollView.add(img)

    var lbl = Titanium.UI.createLabel({
        top: 20,
        left: 20,
        right: 20,
        color:'#5372EF',
        font:{
            fontSize:20,
            fontWeight:'bold'
        },
        text:obj.product_description+'\n\n'+obj.price
    })
    scrollView.add(lbl)

    var sep = Titanium.UI.createView({
        top:10,
        width:'100%',
        height:3,
        backgroundColor:'#F4F5F7'
    })
    scrollView.add(sep)

    //checkout
    var lblCheckout = Titanium.UI.createLabel({
        top: 20,
        left: 20,
        right: 20,
        color:'#000',
        font:{
            fontSize:14,
            fontWeight:'bold'
        },
        text:'Checkout Options'
    })
    scrollView.add(lblCheckout)

    var visaBtn = Titanium.UI.createImageView({
        top:20,
        width:'30%',
        image:'/images/visabutton.jpg'
    });
    scrollView.add(visaBtn)

    var paypalBtn = Titanium.UI.createImageView({
        top:10,
        width:'30%',
        image:'/images/paypalbutton.png'
    });
    scrollView.add(paypalBtn)

    var bitpayBtn = BitPay.createButton();

    scrollView.add(bitpayBtn)


    bitpayBtn.addEventListener('click',function(){   
        doCheckout(win.obj)
    })

    function doCheckout(obj){

        //remove the $ for demo purposes
        obj.price = obj.price.replace('$','')
        var item = {
            'sku': 'tshirt-123',
            'description': obj.product_description,
            'price': parseFloat(obj.price),
            'buyer_email': 'jlewis@bitpay.com'
        }
       
        BitPay.sendTransaction(item)

    }



    return win
}