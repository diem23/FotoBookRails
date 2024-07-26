
 


let followBtns =   document.querySelectorAll('.follow-btn')  
    followBtns.forEach((btn)=>{
    btn.addEventListener('click',function stopPropagation(event){
        console.log(event)
        event.stopPropagation()
        debounceFollow(followAPI)(btn.querySelector('p').innerHTML)
    })
}) 
let unfollowBtns =  document.querySelectorAll('.unfollow-btn')  
    unfollowBtns.forEach((btn)=>{
    btn.addEventListener('click',function stopPropagation(event){
        event.stopPropagation()
        debounceFollow(unfollowAPI)(btn.querySelector('p').innerHTML)
    })
}) 
console.log('users_show loaded')
console.log(followBtns)
console.log(debounceFollow)