let menuItems = [];
let cart = [];

$(function() {
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
        if (item.type === "updateBalance") {
            updateBalance(item.balance);
        }
        if (item.type === "updateItems") {
            menuItems = item.items;
            displayItems();
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://tj_burgershot/exit', JSON.stringify({}));
            display(false);
            return
        }
    };
    $("#close").click(function () {
        $.post('https://tj_burgershot/exit', JSON.stringify({}));
        display(false);
        return
    })
})

function display(bool) {
    if (bool) {
        $(".container").show();
    } else {
        $(".container").hide();
        document.getElementById('checkoutModal').style.display = 'none';
    }
}

function displayItems() {
    const menuContainer = document.getElementById('menuItems');
    menuContainer.innerHTML = '';
    menuItems.forEach(item => {
        const itemElement = `
            <div class="menu-item">
                <div class="item-image"><img src="${item.image}" alt="${item.label}"></div>
                <div class="item-name">${item.label}</div>
                <div class="item-description">${item.description}</div>
                <div class="item-price">$${item.price}</div>
                <button class="btn" onclick="addToCart('${item.item}', '${item.label}', ${item.price})">+1</button>
            </div>
        `;
        menuContainer.innerHTML += itemElement;
    });
}

function updateBalance(balance) {
    document.getElementById('playerBalance').textContent = '$' + balance;
}

function removeFromCart(index) {
    const removedItem = cart[index];
    cart.splice(index, 1);
    showNotification(`${removedItem.name} 已经被移除`, 'info');
    openCheckout(); 
}

function openCheckout() {
    let total = 0;
    let itemList = cart.map((item, index) => {
        total += item.price;
        return `
            <div class="order-item">
                <span>${item.name}: $${item.price}</span>
                <button class="btn btn-remove" onclick="removeFromCart(${index})">移除</button>
            </div>
        `;
    }).join('');
    
    const modalContent = `
        <h2>当前订单</h2>
        <div class="order-items">
            ${cart.length > 0 ? itemList : '<div class="empty-cart">您的订单是空的</div>'}
        </div>
        <h3>总计: $${total}</h3>
        <div class="payment-options">
            <div class="payment-option">
                <input type="radio" id="card" name="payment" value="card">
                <label for="card">刷卡支付</label>
            </div>
            <div class="payment-option">
                <input type="radio" id="cash" name="payment" value="cash">
                <label for="cash">现金支付</label>
            </div>
        </div>
        ${cart.length > 0 ? '<button class="btn" onclick="placeOrder()">确认下单</button>' : ''}
    `;

    document.querySelector('.modal-content').innerHTML = modalContent;
    document.getElementById('checkoutModal').style.display = 'block';
}

function showNotification(message, type = 'info') {
    const notifications = document.getElementById('notifications');
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.textContent = message;

    notifications.appendChild(notification);
    notification.offsetHeight;
    notification.classList.add('show');
    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => {
            notifications.removeChild(notification);
        }, 300);
    }, 3000);
}

function playNotificationSound(type) {
    let soundSrc;
    switch (type) {
        case 'placeOrder':
            fetch(`https://${GetParentResourceName()}/playSoundithinDistance`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ type: type })
            });
            break;
        case 'success':
            soundSrc = 'sounds/ding.mp3';
            break;
        case 'error':
            soundSrc = 'sounds/error.mp3';
            break;
        case 'info':
        default:
            soundSrc = 'sounds/info.mp3';
            break;
    }

    const audio = new Audio(soundSrc);
    audio.volume = 0.5; // 可根据需要调整音量
    audio.play();
}

window.addEventListener('message', function(event) {
    if (event.data.type === "showNotification") {
        showNotification(event.data.message, event.data.notificationType);
    }
});

function placeOrder() {
    const selectedPayment = document.querySelector('input[name="payment"]:checked');
    if (!selectedPayment) {
        showNotification('请选择支付的方式', 'error');
        return;
    }
    let paymentMethod = selectedPayment.value;
    if (cart.length === 0) {
        showNotification('您的订单是空的', 'error');
        return;
    }
    $.post('https://tj_burgershot/createOrder', JSON.stringify({
        items: cart,
        paymentMethod: paymentMethod
    }), function(response) {
        if (response === 'ok') {
            showNotification('订单已发送, 等待制作...', 'success');
            playNotificationSound('placeOrder')
            cart = [];
        } else {
            showNotification('发送订单失败', 'error');
        }
    });
    document.getElementById('checkoutModal').style.display = 'none';
}

function addToCart(itemId, itemName, itemPrice) {
    cart.push({ id: itemId, name: itemName, price: itemPrice });
    showNotification(`${itemName} 加入订单`, 'success');
    playNotificationSound('success')
}

window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === "openMenu") {
        menuItems = item.items;
        displayItems();
        display(true);
    } else if (item.type === "closeMenu") {
        display(false);
    }
});

function closeMenu() {
    $.post('https://tj_burgershot/exit', JSON.stringify({}));
    display(false);
}

function closeCheckout() {
    document.getElementById('checkoutModal').style.display = 'none';
}