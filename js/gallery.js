//THIS IS FOR THE IMAGE MODAL
let index = 0;
let imgs = document.querySelectorAll('.img img');
let modal = document.getElementById('modal');
let modalContent = document.getElementById('modal-content');
let modalImg = document.querySelector('#modal-content img');

//CHECKS WHICH IMG WAS CLICK AND OPENS THE MODAL
imgs.forEach((img, i) => {
    img.addEventListener('click', (e) => {
        index = i;
        document.getElementById('currentImg').src = e.target.src;
        modal.style.display = 'block';
        modalContent.classList.add('modal-open');
        RemoveModalClass();
    });
});

//CLOSE IMAGE
modal.onclick = function() {
    modal.style.display = 'none';
};

//GO TO NEXT IMAGE
// document.getElementById("currentImg").addEventListener("click", () => {
//   if (index >= imgs.length - 1) {
//     index = 0;
//   } else {
//     index++;
//   }
//   modalImg.src = imgs[index].src;
//   modalImg.classList.add("modal-animate");
//   RemoveModalClass();
// });

//CLOSES MODAL WHEN CLICKED OUTSIDE
window.addEventListener('click', function(e) {
    if (e.target == modal) {
        modal.style.display = 'none';
    }
});

function RemoveModalClass() {
    setTimeout(() => {
        modalImg.classList.remove('modal-animate');
    }, 550);
}