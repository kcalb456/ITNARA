$(() => {
    const clickDelete = e => e.target.closest("li").remove();
    
    $("#add").click(e => {
        const li = $("<li>");
        li.addClass(["mt-2", "row"]);

        const div1 = $("<div>");
        div1.addClass(["col-1"]);
        li.append(div1);

        const div2 = $("<div>");
        div2.addClass(["col"]);
        li.append(div2);

        const div3 = $("<div>");
        div3.addClass(["col-1"]);
        li.append(div3);
        
        const input = $("<input>");
        input.attr("type", "file");
        input.attr("name", "uploadFile");        
        input.addClass(["form-control"]);
        
        const button = $("<button>");
        button.text("삭제");
        button.attr("type", "button");
        button.addClass(["btn", "btn-sm", "btn-danger"]);
        
        button.click(clickDelete);
        
        div2.append(input);
        div3.append(button);
        
        $("#files").append(li);
    });
});