// Countdown
// const tangglAcara = new Date('Mar 06, 2022 10:00:00').getTime();

// const sisaWaktu = setInterval(function() {
//     const sekarang = new Date().getTime();
//     const sisa = tangglAcara - sekarang;

//     const sisaHari = Math.floor(sisa / (1000 * 60 * 60 * 24));
//     const sisaJam = Math.floor((sisa % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
//     const sisaMenit = Math.floor((sisa % (1000 * 60 * 60)) / (1000 * 60));
//     const sisaDetik = Math.floor((sisa % (1000 * 60)) / 1000);

//     const hari = document.getElementById('hari');
//     hari.innerHTML = sisaHari;

//     const jam = document.getElementById('jam');
//     jam.innerHTML = sisaJam;

//     const menit = document.getElementById('menit');
//     menit.innerHTML = sisaMenit;

//     const detik = document.getElementById('detik');
//     detik.innerHTML = sisaDetik;

//     if (sisa < 0) {
//         clearInterval(sisaWaktu);
//         hari.innerHTML = '0';
//         jam.innerHTML = '0';
//         menit.innerHTML = '0';
//         detik.innerHTML = '0';
//     }
// }, 1000);

// Copy Text
const alertSatu = document.querySelector('#alertSatu');
document.getElementById('btnSatu').addEventListener('click', function() {
    var range = document.createRange();
    var selection = window.getSelection();
    range.selectNodeContents(document.getElementById('textSatu'));

    selection.removeAllRanges();
    selection.addRange(range);
    document.execCommand('copy');
    alertSatu.classList.toggle('d-none');
});

const alertDua = document.querySelector('#alertDua');
document.getElementById('btnDua').addEventListener('click', function() {
    var range = document.createRange();
    var selection = window.getSelection();
    range.selectNodeContents(document.getElementById('textDua'));

    selection.removeAllRanges();
    selection.addRange(range);
    document.execCommand('copy');
    alertDua.classList.toggle('d-none');
});

const alertTiga = document.querySelector('#alertTiga');
document.getElementById('btnTiga').addEventListener('click', function() {
    var range = document.createRange();
    var selection = window.getSelection();
    range.selectNodeContents(document.getElementById('textTiga'));

    selection.removeAllRanges();
    selection.addRange(range);
    document.execCommand('copy');
    alertTiga.classList.toggle('d-none');
});

// const alertEmpat = document.querySelector("#alertEmpat");
// document.getElementById("btnEmpat").addEventListener("click", function () {
//   var range = document.createRange();
//   var selection = window.getSelection();
//   range.selectNodeContents(document.getElementById("textEmpat"));

//   selection.removeAllRanges();
//   selection.addRange(range);
//   document.execCommand("copy");
//   alertEmpat.classList.toggle("d-none");
// });

function showForm() {
    var div = document.getElementById('hide');
    var show = document.getElementById('show');
    var close = document.getElementById('close');

    if (div.style.display != 'none') {
        hideForm();
    } else {
        div.style.display = 'block';
        show.style.display = 'none';
        close.style.display = 'block';
    }
}

function hideForm() {
    var div = document.getElementById('hide');
    var show = document.getElementById('show');
    var close = document.getElementById('close');

    div.style.display = 'none';

    show.style.display = 'block';
    close.style.display = 'none';
}

function x() {
    return;
}

function DoSmilie(addSmilie, messageDef) {
    var addSmilie, messageDef, revisedMessage;
    var currentMessage = document.chat.pst.value;

    if (currentMessage == messageDef) {
        currentMessage = '';
    }
    revisedMessage = currentMessage + addSmilie;
    document.chat.pst.value = revisedMessage;
    document.chat.pst.focus();
    return;
}