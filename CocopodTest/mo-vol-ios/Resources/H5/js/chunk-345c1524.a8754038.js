(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-345c1524"],{"04f8":function(t,e,c){},1274:function(t,e,c){"use strict";var r=function(){var t=this,e=t.$createElement,c=t._self._c||e;return c("div",{staticClass:"back-title"},[t.iosFlag?t._e():c("div",{staticClass:"bg"}),c("van-nav-bar",{attrs:{"left-text":t.title,"left-arrow":""},on:{"click-left":t.onClickLeft},scopedSlots:t._u([{key:"right",fn:function(){return[t._t("search")]},proxy:!0}],null,!0)})],1)},a=[],i=(c("6b54"),c("2397"),c("d4ec")),n=c("bee2"),o=c("262e"),s=c("99de"),u=c("7e84"),l=c("9ab4"),f=c("60a3"),b=c("4bb5"),d=c("dfaf");function v(t){var e=h();return function(){var c,r=Object(u["a"])(t);if(e){var a=Object(u["a"])(this).constructor;c=Reflect.construct(r,arguments,a)}else c=r.apply(this,arguments);return Object(s["a"])(this,c)}}function h(){if("undefined"===typeof Reflect||!Reflect.construct)return!1;if(Reflect.construct.sham)return!1;if("function"===typeof Proxy)return!0;try{return Date.prototype.toString.call(Reflect.construct(Date,[],(function(){}))),!0}catch(t){return!1}}f["a"].registerHooks(["beforeRouteEnter"]);var p=function(t){Object(o["a"])(c,t);var e=v(c);function c(){var t;return Object(i["a"])(this,c),t=e.apply(this,arguments),t.iosFlag=!1,t.isPageHide=!1,t}return Object(n["a"])(c,[{key:"created",value:function(){this.iosFlag=Object(d["a"])()}},{key:"beforeRouteEnter",value:function(t,e,c){console.log(e.path,t)}},{key:"onClickLeft",value:function(){var t=this.routes,e=t[t.length-2];t.pop(),e&&this.$router.push(e),this.set_history(t)}},{key:"reload",value:function(){this.isPageHide&&window.location.reload()}},{key:"unReload",value:function(){this.isPageHide=!0}}]),c}(f["c"]);Object(l["__decorate"])([Object(f["b"])()],p.prototype,"title",void 0),Object(l["__decorate"])([Object(b["a"])("history")],p.prototype,"routes",void 0),Object(l["__decorate"])([Object(b["b"])("SET_HISTORY")],p.prototype,"set_history",void 0),p=Object(l["__decorate"])([f["a"]],p);var y=p,O=y,j=(c("ff74"),c("2877")),_=Object(j["a"])(O,r,a,!1,null,"23555296",null);e["a"]=_.exports},3067:function(t,e,c){"use strict";var r=c("b0ca"),a=c.n(r);a.a},b0ca:function(t,e,c){},d87e:function(t,e,c){"use strict";c.r(e);var r=function(){var t=this,e=t.$createElement,c=t._self._c||e;return c("div",{staticClass:"success-container"},[c("back-title",{attrs:{title:t.title}}),c("div",{staticClass:"wrapper"},[c("div",[c("van-icon",{staticClass:"icon",attrs:{name:"passed"}})],1),c("div",{staticClass:"desc"},[t._v(t._s(t.$t("drill.submitSuccess")))])])],1)},a=[],i=(c("2397"),c("6b54"),c("d4ec")),n=c("bee2"),o=c("262e"),s=c("99de"),u=c("7e84"),l=c("9ab4"),f=c("60a3"),b=c("1274"),d=c("4bb5");function v(t){var e=h();return function(){var c,r=Object(u["a"])(t);if(e){var a=Object(u["a"])(this).constructor;c=Reflect.construct(r,arguments,a)}else c=r.apply(this,arguments);return Object(s["a"])(this,c)}}function h(){if("undefined"===typeof Reflect||!Reflect.construct)return!1;if(Reflect.construct.sham)return!1;if("function"===typeof Proxy)return!0;try{return Date.prototype.toString.call(Reflect.construct(Date,[],(function(){}))),!0}catch(t){return!1}}var p=function(t){Object(o["a"])(c,t);var e=v(c);function c(){var t;return Object(i["a"])(this,c),t=e.apply(this,arguments),t.title="",t}return Object(n["a"])(c,[{key:"created",value:function(){"A"===this.tabbar&&(this.title=this.$t("activity.detail").toString()),"D"===this.tabbar&&(this.title=this.$t("drill.detail").toString()),"T"===this.tabbar&&(this.title=this.$t("task.detail").toString())}}]),c}(f["c"]);Object(l["__decorate"])([Object(d["a"])("tabbar")],p.prototype,"tabbar",void 0),p=Object(l["__decorate"])([Object(f["a"])({components:{BackTitle:b["a"]}})],p);var y=p,O=y,j=(c("3067"),c("2877")),_=Object(j["a"])(O,r,a,!1,null,"6c7c75ad",null);e["default"]=_.exports},ff74:function(t,e,c){"use strict";var r=c("04f8"),a=c.n(r);a.a}}]);