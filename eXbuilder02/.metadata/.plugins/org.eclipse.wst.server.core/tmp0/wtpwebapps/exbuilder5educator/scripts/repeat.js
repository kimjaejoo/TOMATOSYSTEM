function doList(name) {
    model.send("subList");
    model.getControl(name).rebuild();
}

function doSave(name) {
    var vcRpt = model.getControl(name);
    var flag = vcRpt.getNextFlagPosition(0, "all");

    if (flag == 0) {
        model.msgbox("변경된 데이타가 없습니다.");
        return false;
    }

    var vsParam = vcRpt.getRequestParam("all", "all");
    model.sendAddParam("subSave", vsParam);

    model.msgbox("성공적으로 저장되었습니다.");
    doList();
}