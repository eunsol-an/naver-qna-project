async function emailDupleCheckFromServer(emailVal) {
    try {
        const url = "/users/dupleCheck";
        const config = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=utf-8'
            },
            body: JSON.stringify({email:emailVal})
        }
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

document.getElementById('dupleCheck').addEventListener('click', (e) => {
    e.preventDefault;
    let emailInputed = document.getElementById('email');
    let emailVal = emailInputed.value;

    if (emailVal == '') {
        alert('가입할 이메일을 입력하세요!');
        emailInputed.focus();
        return false;
    } else {
        emailDupleCheckFromServer(emailVal).then(result => {
            console.log(typeof result, result);
            if (parseInt(result)) {
                alert('이미 사용중인 이메일 입니다');
                emailInputed.value = '';
                emailInputed.focus();
                document.getElementById('regBtn').disabled = true;
            } else {
                alert('사용 가능한 이메일 입니다');
                document.getElementById('pwd').focus();
                document.getElementById('regBtn').disabled = false;
            }
        });
    }
});