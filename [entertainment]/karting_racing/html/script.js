window.addEventListener('message', function (event) {
    if (event.data.type === 'showLeaderboard') {
        $('#board').removeClass('hidden');

        // 插入数据
        populateTable('#tbody-alltime', event.data.data.allTime);
        populateTable('#tbody-weekly', event.data.data.weekly);

        // 默认显示历史榜
        $('#table-alltime').removeClass('hidden');
        $('#table-weekly').addClass('hidden');
    }
});

function populateTable(tableId, data) {
    const tbody = $(tableId);
    tbody.empty();
    data.forEach((row, index) => {
        tbody.append(`
            <tr>
                <td class="px-6 py-2">${index + 1}</td>
                <td class="px-6 py-2">${row.name}</td>
                <td class="px-6 py-2">${row.best_time.toFixed(3)}s</td>
            </tr>
        `);
    });
}

// 选项卡切换
$(document).ready(function () {
    $('#tab-alltime').click(function () {
        // 切换按钮颜色
        $(this).removeClass('bg-gray-700').addClass('bg-rose-700');
        $('#tab-weekly').removeClass('bg-rose-700').addClass('bg-gray-700');

        // 切换表格可见性
        $('#table-alltime').removeClass('hidden');
        $('#table-weekly').addClass('hidden');
    });

    $('#tab-weekly').click(function () {
        // 切换按钮颜色
        $(this).removeClass('bg-gray-700').addClass('bg-rose-700');
        $('#tab-alltime').removeClass('bg-rose-700').addClass('bg-gray-700');

        // 切换表格可见性
        $('#table-weekly').removeClass('hidden');
        $('#table-alltime').addClass('hidden');
    });
});

// esc关闭界面
document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape') {
        $('#board').addClass('hidden');
        $.post(`https://${GetParentResourceName()}/karting_racing:closeLeaderboard`, JSON.stringify({}));
    }
});