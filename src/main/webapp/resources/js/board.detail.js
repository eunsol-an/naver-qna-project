document.getElementById('boardRemove').addEventListener('click', (e) => {
    e.preventDefault();
    if (confirm('정말 삭제하시겠습니까?')) {
        const delForm = document.getElementById('boardRmForm');
        delForm.setAttribute('action', '/board/remove');
        delForm.submit();
    }
});

document.addEventListener('click', (e) => {
    if (e.target.classList.contains('th-img')) {
        let imgFileSrc = e.target.getAttribute('src').replace('_th_', '_');
        document.querySelector('.thumb-modal').innerHTML = `<img src="${imgFileSrc}" class="w-100">`;
        document.getElementById('modalThumbBtn').click();
    }
});