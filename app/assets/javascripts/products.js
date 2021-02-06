// common function for fetch the specified currency rate
// parameters needed (selected element, product id)
function fetch_currency_rate(element, product_id) {
    var currency = $(element).find('option:selected').text();
    $.ajax({
        url: "/currencies/fetch_currency_rate",
        type: 'GET',
        dataType: 'json',
        data: {currency: currency, product_id: product_id},
        beforeSend: function( xhr ) {},
        error: function (textStatus, errorThrown) {},
        success:function(data) {
            $(element).parent().find('#product_price').text(data.currency.price + " " + data.currency.currency)
        }
    });
}
