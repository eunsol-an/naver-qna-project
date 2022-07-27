document.addEventListener('DOMContentLoaded', printCommentList);

// 서버로 댓글 전송하기
async function postCommentToServer(cmtData){
    try {
        const url = "/comment/post";
        const config = {
            method : 'post',
            headers : {
                'Content-Type' : 'application/json; charset=utf-8'
            },
            body : JSON.stringify(cmtData)
            };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
    
}

// 댓글 등록 버튼을 눌렀을 때
if (document.getElementById('cmtSbmBtn') != null) {
    document.getElementById('cmtSbmBtn').addEventListener('click', (e) => {
        const cmtInputObj = document.getElementById('cmtText');
        if (cmtInputObj.value == null || cmtInputObj.value == '') {
            alert('답변 내용을 입력해 주세요!');
            cmtInputObj.focus();
            return false;
        }else {
            let cmtData = {
                bno : document.getElementById('bnoVal').innerText,
                writer : document.getElementById('cmtWriter').innerText,
                content : cmtInputObj.value 
            };
            postCommentToServer(cmtData).then(result => {
                if (parseInt(result)) {
                    alert('답변이 등록되었습니다');
                    cmtInputObj.value = "";
                }
                printCommentList();
            });
        }
    });
}

// 서버로부터 댓글 리스트 받아오기
async function getCommentListFromServer(bnoVal, pageNo) {
    try {
        const resp = await fetch("/comment/" + bnoVal + "/" + pageNo);
        const pagingHandler = await resp.json();
        return await pagingHandler;
    } catch (error) {
        console.log(error);
    }
}

// 댓글 리스트 화면에 출력
function spreadCommentList(result) {
    for (const cvo of result.cmtList) {
        let html = `<tr>
                        <td>${cvo.writer}</td>
                        <td>${cvo.content}</td>
                        <td>${cvo.modAt}</td><td>`;
        if (document.getElementById('cmtWriter') != null && document.getElementById('cmtWriter').innerText == cvo.writer) {
                html += `<button class="btn btn-sm cmtModBtn" data-cno="${cvo.cno}">✏</button>
                         <button class="btn btn-sm cmtDelBtn" data-cno="${cvo.cno}">🗑</button>`
                    };
                html +=`</td></tr>`;
        document.getElementById('cmtZone').innerHTML += html;
    }
    if (result.pgvo.pageNo < parseInt(Math.ceil(result.totalCount / 10.0))) {
        let moreBtnZone = document.getElementById('moreBtnZone');
        moreBtnZone.innerHTML = '';
        moreBtnZone.innerHTML += `<button type="button" class="btn btn-outline-secondary moreBtn" data-page="${result.pgvo.pageNo}">MORE +</button>`;
    } else {
        document.getElementById('moreBtnZone').innerHTML = '';
    }
}

// 댓글 리스트 받아오기
function printCommentList() {
    let bnoVal = document.getElementById('bnoVal').innerText;
    const cmtTable = document.getElementById('cmtTable');
    const cmtEmpty = document.getElementById('cmtEmpty');
    getCommentListFromServer(bnoVal, pageNo=1).then(result => {
        console.log(result);
        document.getElementById('cmtZone').innerHTML = "";
        if (result.cmtList.length > 0) {
            cmtEmpty.style.display = 'none';
            cmtTable.style.display = 'table';
            spreadCommentList(result);
        } else {
            cmtEmpty.style.display = 'block';
            cmtTable.style.display = 'none';
        }
    })
}

// 서버로 수정할 댓글 전달하기
async function commentUpdateToServer(cmtData){
    try {
        const url = "/comment/" + cmtData.cno;
        const config = {
            method: 'PUT',
            headers : {
                'Content-Type' : 'application/json; charset=utf-8'
            },
            body : JSON.stringify(cmtData)
        }
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

// 서버로 삭제할 댓글 전달하기
async function commentDeleteToServer(cnoVal, bnoVal){
    try {
        const url = "/comment/" + cnoVal + "/" + bnoVal;
        const config = {method: 'DELETE'}
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

// 댓글 수정, 삭제, MORE 버튼을 눌렀을 때
document.addEventListener('click', (e) => {
    if (e.target.classList.contains('cmtModBtn')) {
        let cnoVal = e.target.dataset.cno;
        let tr = e.target.closest('tr');
        let contentVal = tr.querySelector('td:nth-child(2)').innerText;
        document.querySelector('.mod-modal').innerHTML = `<input type="text" class="form-control cmtModifiedText" value="${contentVal}">`;
        document.querySelector('.modSbmBtn').dataset.cno = cnoVal;
        document.getElementById('modalModBtn').click();
    }
    if (e.target.classList.contains('modSbmBtn')) {
        const cmtModInput = document.querySelector('.cmtModifiedText');
        const cmtTextVal = cmtModInput.value;
        if (cmtTextVal == null || cmtTextVal == '') {
            alert('수정할 답변 내용을 입력하세요!');
            cmtModInput.focus();
            return false;
        }else {
            const cmtData = {
                cno: e.target.dataset.cno,
                content: cmtTextVal
            };
            commentUpdateToServer(cmtData).then(result =>{
                if (parseInt(result)) {
                    document.querySelector('.btn-close').click();
                }
                printCommentList();
            });
        }
    }
    if (e.target.classList.contains('cmtDelBtn')) {
        const cnoVal = e.target.dataset.cno;
        const bnoVal = document.getElementById('bnoVal').innerText;
        commentDeleteToServer(cnoVal, bnoVal).then(result => {
            if (parseInt(result)) {
                alert('답변이 삭제되었습니다');
            }
            printCommentList();
        });
    }
    if (e.target.classList.contains('moreBtn')) {
        e.preventDefault();
        let pageNo = parseInt(e.target.dataset.page) + 1;
        let bnoVal = document.getElementById('bnoVal').innerText;
        getCommentListFromServer(bnoVal, pageNo).then(result => {
            console.log(result);
            if (result.cmtList.length > 0) {
                spreadCommentList(result);
            }
        })
    }
});