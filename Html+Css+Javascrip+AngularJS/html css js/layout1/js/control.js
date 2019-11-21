function checkDangBai() {
    if (checkTieuDe() == true && checkNoiDung() == true && checkDatLich() == true && checkEmail() == true && checkSDT() == true) {
        alert("Dang bai");
    } else if (checkTieuDe() == false) {
        alert("Không được bỏ trống tiêu đề");
    } else if (checkNoiDung() == false) {
        alert("Nhập vào không được ít hơn 200 ký tự")
    } else if (checkDatLich() == false) {
        alert("Chưa đặt lịch");
    } else if (checkEmail() == false) {
        alert("Email không hợp lệ");
    } else if (checkSDT() == false) {
        alert("Số điện thoại không hợp lệ");
    } else {
        alert("Chua the dang bai");
    }
}

function checkEmail() {
    var mail = document.all.email.value;
    var aCong = mail.indexOf('@');
    var doDai = mail.length - 1;
    var dauCham = mail.lastIndexOf('.');
    var dauCach = mail.indexOf(' ');
    if (doDai <= 5 || aCong < 1 || dauCham <= aCong + 1 || dauCach != -1) {
        return false;
    }
    return true;
}



function checkSDT() {
    var number = document.getElementById('sdt').value;
    if (number.length >= 10 && number >= 100000000 && number[0] == 0) {
        return true;
    }
    return false;
}

function checkTheDanhDau() {
    return true;
}

function themBai() {
    var str = document.getElementById('thembai').value;
    txt = str.replace(/,/i, "");
    str.split(",");
    if (str == "the1") {
        document.getElementById('the1').value = str;
        alert("Thêm bài");
    } else if (str == "the2") {
        document.getElementById('the2').value = str;
        alert("Thêm bài");
    } else if (str == "the3") {
        document.getElementById('the3').value = str;
        alert("Thêm bài");
    } else if (str == "the4") {
        document.getElementById('the4').value = str;
        alert("Thêm bài");
    } else {
        alert("Không thêm được bài");

    }
}

function resetAll() {
    document.getElementById("tieude").value = "";
    document.getElementById("asd").value = "";
    document.getElementById("date").value = "";
}

function checkTieuDe() {
    var str = document.getElementById("tieude").value;
    if (str != "") return true;
    return false;
}

function CheckKyTu() {
    if (document.getElementById("asd").value.length < 200) {
        var str = document.getElementById("asd").value.length;
        document.getElementById("hienThiSoKT").innerHTML = "Bạn đã viết được " + str + " ký tự";
        return false;
    } else {
        document.getElementById("hienThiSoKT").innerHTML = "Đã trên 200 ký tự";
        return true;
    }

}

function checkNoiDung() {
    if (CheckKyTu() == true) return true;
    return false;
}

function checkDatLich() {
    DatLich();
    return true;
}

function DatLich() {
    document.getElementById("date").disabled = true;
}

function KhoiTaolink() {
    var x = document.getElementById("tieude").value;
    x = x.toLowerCase();
    x = x.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
    x = x.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
    x = x.replace(/ì|í|ị|ỉ|ĩ/g, "i");
    x = x.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
    x = x.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
    x = x.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
    x = x.replace(/đ/g, "d");
    x = x.replace(/!|@|%|\^|\*|\(|\)|\+|\=|\<|\>|\?|\/|,|\.|\:|\;|\'|\"|\&|\#|\[|\]|~|\$|_|`|-|{|}|\||\\/g, "");
    x = x.replace(/ + /g, "");
    x = x.trim();
    x = x.replace(/ /g, "-");
    document.getElementById("tao-link").innerHTML = "localhost/" + x;
}