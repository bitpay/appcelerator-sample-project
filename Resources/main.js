var win;

exports.getMain = function () {

    win = Titanium.UI.createWindow({
        backgroundColor: '#fff',
        layout: 'vertical',
        navTintColor: "fff",
    });

    var headerView = Titanium.UI.createView({
        top:0,
        left:0,
        right:0,
        height:60,
        backgroundColor:'#2C418B'
    })
    win.add(headerView)

    var hlabel = Titanium.UI.createLabel({
        top:25,
        color:'#fff',
        text:'My T-Shirt Store',
        font:{
            fontSize:18,
            fontWeight:'bold'
        }
    })
    headerView.add(hlabel)

    var tableView = Titanium.UI.createTableView({
        layout: 'vertical',
        top:0,
        left:0,
        right:0,
        bottom:0,
        backgroundColor: '#FFF',
        separatorColor:'#FFF',
        separatorStyle : 'NONE', 

    })
    win.add(tableView)

    //add some products
    var row1 = Titanium.UI.createTableViewRow({
        height:Ti.UI.SIZE,
        backgroundColor: 'transparent',
		selectedBackgroundColor: 'transparent',
       
    });
    var wrap1 = Titanium.UI.createView({
        top:10,
        left:0,
        right:0,
       //borderColor:'#F4F5F7',
        height:Ti.UI.SIZE
    });
    row1.add(wrap1)

    var img1 = Titanium.UI.createImageView({
        left:10,
        top:15,
        bottom:20,
        width:100,
        height:'auto',
        image:'/images/flash.jpeg'
    })
    wrap1.add(img1)

    var lbl1 = Titanium.UI.createLabel({
        top:10,
        left:125,
        color:'#5372EF',
        font:{
            fontSize:20,
            fontWeight:'bold'
        },
        text:'The Flash'
    })
    wrap1.add(lbl1)

    var lbl11 = Titanium.UI.createLabel({
        top:40,
        left:125,
        right:10,
        color:'#5372EF',
        font:{
            fontSize:16
        },
        text:'The fastest man alive! Fast as fast can be you\'ll never catch me!'  
    })
    wrap1.add(lbl11)

    var lbl111 = Titanium.UI.createLabel({
        bottom:10,
        left:125,
        color:'#5372EF',
        font:{
            fontSize:14,fontWeight:'bold'
        },
        text:'$9.99'  
    })
    wrap1.add(lbl111)

    row1.price = lbl111.text
    row1.product_description = lbl11.text
    row1.image = img1.image
    row1.header = lbl1.text

    //

    //add some products
    var row2 = Titanium.UI.createTableViewRow({
        height:Ti.UI.SIZE,
        backgroundColor: 'transparent',
		selectedBackgroundColor: 'transparent',
       
    });
    var wrap2 = Titanium.UI.createView({
        top:10,
        left:0,
        right:0,
       //borderColor:'#F4F5F7',
        height:Ti.UI.SIZE
    });
    row2.add(wrap2)

    var img2 = Titanium.UI.createImageView({
        left:10,
        top:15,
        bottom:20,
        width:100,
        height:'auto',
        image:'/images/batman.jpeg'
    })
    wrap2.add(img2)

    var lbl2 = Titanium.UI.createLabel({
        top:10,
        left:125,
        color:'#5372EF',
        font:{
            fontSize:20,
            fontWeight:'bold'
        },
        text:'Batman'
    })
    wrap2.add(lbl2)

    var lbl22 = Titanium.UI.createLabel({
        top:40,
        left:125,
        right:10,
        color:'#5372EF',
        font:{
            fontSize:16
        },
        text:'I wish we had skipped movie night.'  
    })
    wrap2.add(lbl22)

    var lbl222 = Titanium.UI.createLabel({
        bottom:10,
        left:125,
        color:'#5372EF',
        font:{
            fontSize:14,fontWeight:'bold'
        },
        text:'$6.99'  
    })
    wrap2.add(lbl222)

    row2.price = lbl222.text
    row2.product_description = lbl22.text
    row2.image = img2.image
    row2.header = lbl2.text


    //

    //add some products
    var row3 = Titanium.UI.createTableViewRow({
        height:Ti.UI.SIZE,
        backgroundColor: 'transparent',
		selectedBackgroundColor: 'transparent',
       
    });
    var wrap3 = Titanium.UI.createView({
        top:10,
        left:0,
        right:0,
       //borderColor:'#F4F5F7',
        height:Ti.UI.SIZE
    });
    row3.add(wrap3)

    var img3 = Titanium.UI.createImageView({
        left:10,
        top:15,
        bottom:20,
        width:100,
        height:'auto',
        image:'/images/superman.jpg'
    })
    wrap3.add(img3)

    var lbl3 = Titanium.UI.createLabel({
        top:10,
        left:125,
        color:'#5372EF',
        font:{
            fontSize:20,
            fontWeight:'bold'
        },
        text:'Superman'
    })
    wrap3.add(lbl3)

    var lbl33 = Titanium.UI.createLabel({
        top:40,
        left:125,
        right:10,
        color:'#5372EF',
        font:{
            fontSize:16
        },
        text:'My mustache is the best mustache on Krypton.'  
    })
    wrap3.add(lbl33)

    var lbl333 = Titanium.UI.createLabel({
        bottom:10,
        left:125,
        color:'#5372EF',
        font:{
            fontSize:14,fontWeight:'bold'
        },
        text:'$12.99'  
    })
    wrap3.add(lbl333)

    row3.price = lbl333.text
    row3.product_description = lbl33.text
    row3.image = img3.image
    row3.header = lbl3.text


    //
    //add some products
    var row4 = Titanium.UI.createTableViewRow({
        height:Ti.UI.SIZE,
        backgroundColor: 'transparent',
		selectedBackgroundColor: 'transparent',
       
    });
    var wrap4 = Titanium.UI.createView({
        top:10,
        left:0,
        right:0,
       //borderColor:'#F4F5F7',
        height:Ti.UI.SIZE
    });
    row4.add(wrap4)

    var img4 = Titanium.UI.createImageView({
        left:10,
        top:15,
        bottom:20,
        width:100,
        height:'auto',
        image:'/images/deadpool.jpeg'
    })
    wrap4.add(img4)

    var lbl4 = Titanium.UI.createLabel({
        top:10,
        left:125,
        color:'#5372EF',
        font:{
            fontSize:20,
            fontWeight:'bold'
        },
        text:'Deadpool'
    })
    wrap4.add(lbl4)

    var lbl44 = Titanium.UI.createLabel({
        top:40,
        left:125,
        right:10,
        color:'#5372EF',
        font:{
            fontSize:16
        },
        text:'Green Lantern was the best superhero movie.'  
    })
    wrap4.add(lbl44)

    var lbl444 = Titanium.UI.createLabel({
        bottom:10,
        left:125,
        color:'#5372EF',
        font:{
            fontSize:14,fontWeight:'bold'
        },
        text:'$25.99'  
    })
    wrap4.add(lbl444)

    row4.price = lbl444.text
    row4.product_description = lbl44.text
    row4.image = img4.image
    row4.header = lbl4.text    





    tableView.appendRow(row1)
    tableView.appendRow(row2)
    tableView.appendRow(row3)
    tableView.appendRow(row4)

    tableView.addEventListener('click',function(e){
        var obj = {
            'price':e.rowData.price,
            'product_description':e.rowData.product_description,
            'image':e.rowData.image,
            'header':e.rowData.header
        }


        var win = require('details.js').getMain(obj);
        win.open({modal:true})

    })
    
    return win
};