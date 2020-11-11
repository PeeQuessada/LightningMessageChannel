({
    handleMessage: function (cmp, message, helper) {
        console.log('entrou aqui');
        // Read the message argument to get the values in the message payload
        if (message != null && message.getParam("recordData") != null) {
            cmp.set("v.record", message.getParam("recordData").value);
        }
    }
})