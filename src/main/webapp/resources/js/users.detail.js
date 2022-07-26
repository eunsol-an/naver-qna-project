document.getElementById('usersRemove').addEventListener('click', (e) => {
    e.preventDefault();
    const emailVal = document.getElementById('emVal').innerText;
    document.getElementById('em').value = emailVal;
    const delForm = document.getElementById('usersRmForm');
    delForm.setAttribute('action', '/users/remove');
    delForm.submit();
});