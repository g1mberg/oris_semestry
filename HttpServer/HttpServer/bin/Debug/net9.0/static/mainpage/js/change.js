const editBtn = document.getElementById("editTourBtn");

const tourId = editBtn.dataset.tourId;
let initialState = null;
let panelEl = null;

editBtn.addEventListener("click", toggleEditMode);

function toggleEditMode() {
    if (panelEl) {
        cancelEdit();
        return;
    }

    initialState = snapshotContent();
    setEditable(true);
    createSavePanel();
}

function snapshotContent() {
    return {
        'tour-title': getElementText('tour-title'),
        'tour-desc': getElementText('tour-desc'),
        'price-1': getElementText('price-1'),
        'price-2': getElementText('price-2'),
    };
}

function getElementText(id) {
    const el = document.getElementById(id);
    return el ? el.innerText.trim() : '';
}

function getChangedFields() {
    if (!initialState) return {};

    const currentState = snapshotContent();
    const changes = {};

    Object.entries(currentState).forEach(([id, currentText]) => {
        const initialText = initialState[id];
        if (currentText !== initialText || !currentText) {
            changes[id] = currentText;
        }
    });

    return changes;
}

function restoreContent(state) {
    Object.entries(state).forEach(([id, text]) => {
        const el = document.getElementById(id);
        if (el && text !== undefined) {
            el.textContent = text;
        }
    });
}

function setEditable(isEditable) {
    const ids = [
        'tour-title', 'tour-desc', 'price-1', 'price-2'
    ];

    ids.forEach(id => {
        const el = document.getElementById(id);
        if (el) {
            el.contentEditable = isEditable;
            el.classList.toggle("editable-highlight", isEditable);
        }
    });
}

function createSavePanel() {
    panelEl = document.createElement("div");
    panelEl.className = "save-panel";
    panelEl.innerHTML = `
        <button class="save-btn" type="button">Сохранить изменения</button>
        <button class="cancel-btn" type="button">Отмена</button>
    `;

    panelEl.querySelector(".save-btn").onclick = saveChanges;
    panelEl.querySelector(".cancel-btn").onclick = cancelEdit;
    document.body.appendChild(panelEl);
}

function destroySavePanel() {
    if (panelEl) {
        panelEl.remove();
        panelEl = null;
    }
}

async function saveChanges() {
    if (!tourId) return;

    const changes = getChangedFields();

    if (Object.keys(changes).length === 0) {
        console.log("Изменений нет");
        setEditable(false);
        destroySavePanel();
        initialState = null;
        return;
    }
    
    const errors = validate();
    if (errors.length > 0) {
        console.error("Ошибки валидации:", errors);
        alert("Исправьте ошибки:\n" + errors.join('\n'));
        return;
    }

    console.log("Отправляем изменения:", changes);

    try {
        const response = await fetch(`/admin/save-tour?id=${encodeURIComponent(tourId)}`, {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({changes})
        });

        if (!response.ok) throw new Error(`HTTP ${response.status}`);

        console.log("Сохранено!");
        setEditable(false);
        destroySavePanel();
        initialState = null;

    } catch (e) {
        console.error("Ошибка:", e);
    }
}

function cancelEdit() {
    restoreContent(initialState);
    setEditable(false);
    destroySavePanel();
    initialState = null;
}

function validate() {
    const errors = [];
    const allFields = snapshotContent();
    
    ['price-1', 'price-2'].forEach(id => {
        const text = allFields[id];

        if (!text || text.trim() === '') {
            errors.push(`${id}: обязательно`);
            return;
        }

        const isValidNumber = text.trim().match(/^[\d\s]+(?:,[\d]{2})?$/);
        if (!isValidNumber) {
            errors.push(`${id}: только число (123 или 123,45)`);
        }
    });
    
    ['tour-title', 'tour-desc'].forEach(id => {
        const text = allFields[id];
        if (!text || text.trim() === '') {
            errors.push(`${id}: обязательно`);
        }
    });

    return errors;
}


