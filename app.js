let currentUser = JSON.parse(localStorage.getItem('currentUser')) || null;
let cart = JSON.parse(localStorage.getItem('cart')) || [];

document.addEventListener('DOMContentLoaded', () => {
    updateUserDisplay();
    updateCartCount();
});

function updateUserDisplay() {
    const display = document.getElementById('user-display');
    if (display) {
        display.innerText = currentUser ? `Hola, ${currentUser.name}` : 'Invitado';
    }
}

function updateCartCount() {
    const count = document.getElementById('cart-count');
    if (count) count.innerText = cart.length;
}

function addToCart(nombre, precio) {
    cart.push({ nombre, precio });
    localStorage.setItem('cart', JSON.stringify(cart));
    updateCartCount();
    logSQL(`INSERT INTO carrito_temp (producto, precio) VALUES ('${nombre}', ${precio});`);
    alert(`"${nombre}" agregado al carrito.`);
}

function toggleCart() {
    const modal = document.getElementById('cart-modal');
    modal.style.display = (modal.style.display === 'flex') ? 'none' : 'flex';

    const cartItems = document.getElementById('cart-items');
    let total = 0;
    cartItems.innerHTML = '';
    
    cart.forEach(item => {
        total += item.precio;
        cartItems.innerHTML += `<p>• ${item.nombre} - <strong>$${item.precio.toFixed(2)}</strong></p>`;
    });

    document.getElementById('cart-total').innerText = total.toFixed(2);
}

function handleCheckout(e) {
    e.preventDefault();
    if (!currentUser) {
        alert('Debes iniciar sesión para realizar la compra.');
        toggleCart();
        toggleAuthModal();
        return;
    }
    if (cart.length === 0) return alert('El carrito está vacío.');

    const address = document.getElementById('ship-address').value;
    const payment = document.getElementById('pay-method').value;
    const total = document.getElementById('cart-total').innerText;

    logSQL(`INSERT INTO ventas (usuario_id, total, direccion_envio, metodo_pago) VALUES (${currentUser.id}, ${total}, '${address}', '${payment}');`);
    alert('Venta procesada y registrada en la base de datos SQL.');

    cart = [];
    localStorage.removeItem('cart');
    updateCartCount();
    toggleCart();
}

function handleRegister(e) {
    e.preventDefault();
    const name = document.getElementById('reg-name').value;
    const email = document.getElementById('reg-email').value;
    const pass = document.getElementById('reg-pass').value;

    currentUser = { id: 101, name, email };
    localStorage.setItem('currentUser', JSON.stringify(currentUser));
    updateUserDisplay();
    toggleAuthModal();

    logSQL(`INSERT INTO usuarios (nombre, email, password) VALUES ('${name}', '${email}', '${pass}');`);
    alert('Usuario registrado con éxito.');
}

function handleLogin(e) {
    e.preventDefault();
    const email = document.getElementById('login-email').value;
    currentUser = { id: 101, name: email.split('@')[0], email };
    localStorage.setItem('currentUser', JSON.stringify(currentUser));
    updateUserDisplay();
    toggleAuthModal();

    logSQL(`SELECT * FROM usuarios WHERE email = '${email}';`);
    alert('Sesión iniciada correctamente.');
}

function toggleAuthModal() {
    const modal = document.getElementById('auth-modal');
    modal.style.display = (modal.style.display === 'flex') ? 'none' : 'flex';
}

function switchTab(tab) {
    document.getElementById('form-login').classList.toggle('hidden', tab !== 'login');
    document.getElementById('form-register').classList.toggle('hidden', tab !== 'register');
    document.querySelectorAll('.tab-btn')[0].classList.toggle('active', tab === 'login');
    document.querySelectorAll('.tab-btn')[1].classList.toggle('active', tab === 'register');
}

function logSQL(query) {
    const consoleLog = document.getElementById('sql-log');
    if (consoleLog) consoleLog.innerText = query;
}