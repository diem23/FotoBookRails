console.log('global_use.js loaded');
function followAPI(id){
    $.ajax({
        url: "/discover/follow",
        type: "PUT",
        data: {user_id: id},
        success: function(data) {},
        error: function(data) {}
    })
}
const debounceFollow= function (func, timeout = 3000){
    return (...args) => {
        console.log(this.timer)
        clearTimeout(this.timer);
        this.timer = setTimeout(() => { func.apply(this, args); }, timeout);
    };
}
console.log('global_use.js finishes loaded');   