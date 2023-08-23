function tampilkanSemuaMenu() {
    $('#daftar-menu').html('');
    $.getJSON('kalung.json', function(data) {
        let menu = data.menu;
        $.each(menu, function(i, data) {
            $('#daftar-menu').append(
                '<div class="col-md-3"><div class="card mb-3 bg-dark"><div class="card-header text-light bg-secondary">' +
                data.nama +
                '</div><div class="card-body"><img src="' +
                data.gambar +
                '" class="card-img-top"><h5 class="card-title mt-1 text-center"><a href="' +
                data.deskripsi +
                '"><i class="bi bi-hand-index-thumb"></i> Cek Product</a></h5><h5 class="card-text text-center text-light bg-secondary">Rp. ' +
                data.harga +
                '</h5><a href="http://wa.me/6281222236665" class="btn btn-success btn-block"><i class="bi bi-whatsapp"></i> Pesan sekarang</a></div></div></div>'
            );
        });
    });
}

tampilkanSemuaMenu();

$('.nav-link').on('click', function() {
    $('.nav-link').removeClass('active');
    $(this).addClass('active');

    let kategori = $(this).html();
    $('h1').html(kategori);

    if (kategori == 'Kalung') {
        tampilkanSemuaMenu();
        return;
    }

    $.getJSON('kalung.json', function(data) {
        let menu = data.menu;
        let content = '';

        $.each(menu, function(i, data) {
            if (data.kategori == kategori.toLowerCase()) {
                content +=
                    '<div class="col-md-3"><div class="card mb-3 bg-dark"><div class="card-header text-light bg-secondary">' +
                    data.nama +
                    '</div><div class="card-body"><img src="' +
                    data.gambar +
                    '" class="card-img-top"><h5 class="card-title mt-1 text-center"><a href="' +
                    data.deskripsi +
                    '"><i class="bi bi-hand-index-thumb"></i> Cek Product</a></h5><h5 class="card-text text-center text-light bg-secondary">Rp. ' +
                    data.harga +
                    '</h5><a href="http://wa.me/6281222236665" class="btn btn-success btn-block"><i class="bi bi-whatsapp"></i> Pesan sekarang</a></div></div></div>';
            }
        });
        $('#daftar-menu').html(content);
    });
});
