let currentTab = "forbes";
let allTabs = {}; // 存储排行榜结构，后续切换用

window.addEventListener('message', function (event) {
  if (event.data.type === "showLeaderboard") {
    currentTab = event.data.tab || "forbes";
    document.getElementById("leaderboard-wrapper").style.display = "flex";

    // 请求所有排行榜数据结构
    fetch(`https://${GetParentResourceName()}/rb-ranking:nui:getAllLeaderboards`, {
      method: "POST"
    })
      .then(res => res.json())
      .then(data => {
        allTabs = data;
        renderTabs(data);              // 动态构建侧边栏 tab
        loadLeaderboard(currentTab);  // 加载当前 tab 的数据
      })
      .catch(err => console.error("获取排行榜结构失败:", err));
  }
});

function renderTabs(tabs) {
  const sidebar = document.getElementById("sidebar-tabs");
  sidebar.innerHTML = ""; // 清空原内容

  Object.entries(tabs).forEach(([id, info]) => {
    const div = document.createElement("div");
    div.className = "tab" + (id === currentTab ? " active" : "");
    div.textContent = info.label;
    div.addEventListener("click", () => {
      currentTab = id;
      document.querySelectorAll(".tab").forEach(t => t.classList.remove("active"));
      div.classList.add("active");
      loadLeaderboard(id);
    });
    sidebar.appendChild(div);
  });
}

function loadLeaderboard(tabId) {
  fetch(`https://${GetParentResourceName()}/rb-ranking:nui:getLeaderboardData`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({ id: tabId })
  })
    .then(res => res.json())
    .then(data => renderLeaderboard(data))
    .catch(err => console.error("排行榜数据获取失败:", err));
}

function renderLeaderboard(payload) {
  const { label, columns, data } = payload;

  document.querySelector(".header h2").textContent = label;

  const thead = document.querySelector("#forbes-table thead tr");
  const tbody = document.querySelector("#forbes-table tbody");
  thead.innerHTML = "";
  tbody.innerHTML = "";

  columns.forEach(col => {
    const th = document.createElement("th");
    th.textContent = col.label;
    thead.appendChild(th);
  });

  data.forEach(entry => {
    const row = document.createElement("tr");
    // 排名标记（前3名进行额外特殊处理）
    if (entry.rank === 1) entry.rank = `<span style="font-size: 22px;">🥇</span>`;
    else if (entry.rank === 2) entry.rank = `<span style="font-size: 22px;">🥈</span>`;
    else if (entry.rank === 3) entry.rank = `<span style="font-size: 22px;">🥉</span>`;
    columns.forEach(col => {
      const td = document.createElement("td");
      const val = entry[col.name];
      if (typeof val === 'string' && val.startsWith('<span')) {
        td.innerHTML = val;
      } else {
        td.textContent = typeof val === 'number' ? val.toLocaleString() : val;
      }
      row.appendChild(td);
    });
    tbody.appendChild(row);
  });
}

document.addEventListener("keydown", (e) => {
  if (e.key === 'Escape') {
    document.getElementById("leaderboard-wrapper").style.display = "none";
    fetch(`https://${GetParentResourceName()}/rb-ranking:nui:closeLeaderboard`, {
      method: "POST"
    });
  }
});
