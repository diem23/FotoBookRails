console.log('photos_feed loaded')


let userBtns = document.querySelectorAll('.specific-user-btn')
userBtns.forEach((btn)=>{
    console.log("hello")
    btn.addEventListener('click',function stopPropagation(event){
        event.stopPropagation();
    })
}) 
let reactPhotoBtns = document.querySelectorAll('.react-photo-btn')
reactPhotoBtns.forEach((btn)=>{
    btn.addEventListener('click',function stopPropagation(event){
        console.log("onclick like")
        event.stopPropagation();
        debounceReact(reactPhotoApi)(btn.querySelector('p').innerHTML)
    })
}) 

let unreactPhotoBtns = document.querySelectorAll('.unreact-photo-btn')
unreactPhotoBtns.forEach((btn)=>{
    btn.addEventListener('click',function stopPropagation(event){
        console.log("onclick like")
        event.stopPropagation();
        debounceReact(unreactPhotoApi)(btn.querySelector('p').innerHTML)
    })
}) 