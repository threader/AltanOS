/* Source and licensing information for the line(s) below can be found at http://cdn1.alphr.com/profiles/dennis_distro/modules/contrib/picture/picturefill/picturefill.js. */

(function(w,parent){"use strict";w.picturefill=function(parent){function _copyAttributes(src,tar){if(src.getAttribute('data-width')&&src.getAttribute('data-height')){tar.width=src.getAttribute('data-width');tar.height=src.getAttribute('data-height');}
else{tar.removeAttribute('width');tar.removeAttribute('height');}}
if(!parent||!parent.getElementsByTagName){parent=w.document;}
var ps=parent.getElementsByTagName('span');for(var i=0,il=ps.length;i<il;i++){if(ps[i].getAttribute('data-picture')!==null){var sources=ps[i].getElementsByTagName('span');var picImg=null;var matches=[];for(var j=0,jl=sources.length;j<jl;j++){var media=sources[j].getAttribute('data-media');if(!media||(w.matchMedia&&w.matchMedia(media).matches)){matches.push(sources[j]);}}
if(matches.length){var match=matches.pop();picImg=ps[i].getElementsByTagName('img')[0];if(!picImg){picImg=w.document.createElement('img');picImg.alt=ps[i].getAttribute('data-alt')||'';picImg.title=ps[i].getAttribute('data-title')||'';ps[i].appendChild(picImg);}
if(picImg.getAttribute('src')!==match.getAttribute('data-src')){picImg.src=match.getAttribute('data-src');_copyAttributes(match,picImg);}}}}};if(w.addEventListener){w.addEventListener('resize',w.picturefill,false);w.addEventListener('DOMContentLoaded',function(){w.picturefill();w.removeEventListener('load',w.picturefill,false);},false);w.addEventListener('load',w.picturefill,false);}
else if(w.attachEvent){w.attachEvent('onload',w.picturefill);}})(this);;
/* Source and licensing information for the above line(s) can be found at http://cdn1.alphr.com/profiles/dennis_distro/modules/contrib/picture/picturefill/picturefill.js. */
/* Source and licensing information for the line(s) below can be found at http://cdn1.alphr.com/profiles/dennis_distro/modules/contrib/picture/picture.js. */

if(typeof Drupal!=='undefined'&&typeof jQuery!=='undefined'){(function($){Drupal.behaviors.picture={attach:function(context){window.picturefill($(context));if(context==='#cboxLoadedContent'&&$(context).find('picture, [data-picture]').length){$.colorbox.resize();$('img',context).once('colorbox-lazy-load',function(){$(this).load(function(){this.style.maxHeight=$(window).height()+'px';this.style.maxWidth=$(window).width()+'px';$.colorbox.resize({innerHeight:this.height,innerWidth:this.width});this.style.maxHeight=null;this.style.maxWidth=null;});});}}};})(jQuery);};
/* Source and licensing information for the above line(s) can be found at http://cdn1.alphr.com/profiles/dennis_distro/modules/contrib/picture/picture.js. */
