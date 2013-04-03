(function($) {

  var SearchForm = Cell.create('SearchForm');

  SearchForm.prototype.initialize = function() {
    var _this = this;

    _this.form = _this.$target.find("form");
    _this.termField = _this.$target.find('input[type="text"]');
    _this.backlog = Backlog.instances[0];

    _this.form.on("submit", function(e) {
      e.preventDefault();
    });

    _this.$target.on("keyup", ":input", function() {
      clearTimeout(_this.timer);
      _this.timer = setTimeout(function() {
        _this.backlog.refresh(true);
      }, 300);
    });
  };

  SearchForm.prototype.resetState = function(data) {
    var _this = this;

    _this.form.populate({ search: { term: data.query } });
  };

  SearchForm.prototype.options = function() {
    var _this = this;
    return _this.getTerm();
  };

  SearchForm.prototype.getTerm = function() {
    var _this = this;
    return _this.form.formParams()["search"]["term"];
  };
})(jQuery);
