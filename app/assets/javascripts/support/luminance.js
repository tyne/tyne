(function($, undefined) {
  function Luminance() {}

  Luminance.standard = function(red, green, blue) {
    return (0.2126*red) + (0.7152*green) + (0.0722*blue);
  };

  Luminance.isBright = function(r, g, b) {
    return Luminance.standard(r,g,b) > (255/2);
  };

  Luminance.isDark = function(r, g, b) {
    return Luminance.standard(r,g,b) < (255/2);
  };

  ClassRegistry.set('Luminance', Luminance);
})(jQuery);
