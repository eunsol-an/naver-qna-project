const regExpPrevent = new RegExp("\.(exe|sh|bat|js|msi|dll)$");
const regExpImage = new RegExp("\.(jpg|jpeg|png|gif)$", "i");
const maxSize = 2 * 1024 * 1024; // 2MB
function fileSizeAndTypeValidation(fileName, fileSize){
    if (regExpPrevent.test(fileName)) {
        return 0;
    }else if (!regExpImage.test(fileName)) {
        return 0;
    }else if (fileSize > maxSize) {
        return 0;
    }else {
        return 1;
    }
}

document.addEventListener('change', (e) => {
    if (e.target.id == 'files') {
        const fileObjects = document.getElementById('files').files;
        console.log(fileObjects);

        const div = document.getElementById('fileZone');
        div.innerHTML = '';
        let ul = '<ul class="list-group list-group-flush">';

        let isOk = 1;
        for (const file of fileObjects) {
            let validFile = fileSizeAndTypeValidation(file.name, file.size);
            isOk *= validFile;
            ul += `<li class="${validFile ? "bg-success text-white ":"bg-danger text-white "}list-group-item d-flex justify-content-between align-items-start">`;
            ul += `<div class="ms-2 me-auto">${file.name}</div>`;
            ul += `<span class="badge bg-primary rounded-pill">${file.size}</span></li>`;
        }
        ul += '</ul>';
        div.innerHTML = ul;
    }
});