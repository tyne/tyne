(function(){
  var bipOldClickHandler = BestInPlaceEditor.prototype.clickHandler;
  var bipOldAbort = BestInPlaceEditor.prototype.abort;
  var bipOldUpdate = BestInPlaceEditor.prototype.update;

  BestInPlaceEditor.prototype.clickHandler = function(event) {
    event.data.editor.element.addClass("editing_in_place");
    bipOldClickHandler(event);
  };

  BestInPlaceEditor.prototype.abort = function() {
    bipOldAbort.apply(this);
    this.element.removeClass("editing_in_place");
  };

  BestInPlaceEditor.prototype.update = function() {
    bipOldUpdate.apply(this);
    this.element.removeClass("editing_in_place");
  };
})();
