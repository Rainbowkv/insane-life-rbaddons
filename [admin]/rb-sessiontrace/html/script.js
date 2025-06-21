let originalData = [];  // 存储原始数据
let filteredData = [];  // 当前显示的数据
let currentPage = 1;
const pageSize = 10;

window.addEventListener('message', function (event) {
    if (event.data.action === 'show') {
        document.getElementById('overlay').style.display = 'none';
        document.getElementById('tracker-panel').style.display = 'block';
        currentPage = 1;
    }

    if (event.data.action === 'updateData') {
        originalData = event.data.sessions;
        filteredData = [...originalData];
        renderPage();
    }
});

document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') {
        closePanel();
    }
});

function renderPage() {
    const tbody = document.getElementById('sessionData');
    tbody.innerHTML = '';

    const start = (currentPage - 1) * pageSize;
    const pageData = filteredData.slice(start, start + pageSize);

    pageData.forEach(row => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>${row.citizenid}</td>
            <td>${row.name}</td>
            <td>${row.src}</td>
            <td>${formatTime(row.login_time)}</td>
            <td>${formatTime(row.drop_time)}</td>
        `;
        tbody.appendChild(tr);
    });

    document.getElementById('pageIndicator').innerText = `第 ${currentPage} 页 / 共 ${Math.ceil(filteredData.length / pageSize)} 页`;
}

function applyFilter() {
    const val = document.getElementById('srcFilter').value.trim();
    if (val === '') {
        filteredData = [...originalData]; // 重置为所有数据
    } else {
        filteredData = originalData.filter(r => r.src.toString() === val);
    }
    currentPage = 1;
    renderPage();
}

function nextPage() {
    if (currentPage < Math.ceil(filteredData.length / pageSize)) {
        currentPage++;
        renderPage();
    }
}

function prevPage() {
    if (currentPage > 1) {
        currentPage--;
        renderPage();
    }
}

function closePanel() {
    document.getElementById('overlay').style.display = 'none';
    document.getElementById('tracker-panel').style.display = 'none';
    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST',
        body: '{}',
        headers: { 'Content-Type': 'application/json' }
    });
}

function formatTime(millis) {
    const date = new Date(millis);
    const Y = date.getFullYear();
    const M = String(date.getMonth() + 1).padStart(2, '0');
    const D = String(date.getDate()).padStart(2, '0');
    const h = String(date.getHours()).padStart(2, '0');
    const m = String(date.getMinutes()).padStart(2, '0');
    const s = String(date.getSeconds()).padStart(2, '0');
    return `${Y}-${M}-${D} ${h}:${m}:${s}`;
}
