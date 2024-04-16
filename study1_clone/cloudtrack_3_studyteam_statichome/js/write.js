const writeBt = document.querySelector('.header-upper__writeBt');
const writeMenu = document.querySelector('.header-upper__lists');

const openWriteMenu = () => {
    writeMenu.classList.add('openWirteMenu');
}

const closeWriteMenu = (event) => {
    if (event.target !== writeMenu && event.target !== writeBt) {
        writeMenu.classList.remove('openWirteMenu');
    }
}

writeBt.addEventListener("click", openWriteMenu);
window.addEventListener("click", closeWriteMenu);