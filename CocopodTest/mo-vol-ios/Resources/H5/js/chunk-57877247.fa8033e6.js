(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-57877247"],{"04f8":function(t,e,s){},"087c":function(t,e,s){"use strict";var i=s("dda7"),a=s.n(i);a.a},1274:function(t,e,s){"use strict";var i=function(){var t=this,e=t.$createElement,s=t._self._c||e;return s("div",{staticClass:"back-title"},[t.iosFlag?t._e():s("div",{staticClass:"bg"}),s("van-nav-bar",{attrs:{"left-text":t.title,"left-arrow":""},on:{"click-left":t.onClickLeft},scopedSlots:t._u([{key:"right",fn:function(){return[t._t("search")]},proxy:!0}],null,!0)})],1)},a=[],n=(s("6b54"),s("2397"),s("d4ec")),r=s("bee2"),c=s("262e"),o=s("99de"),u=s("7e84"),f=s("9ab4"),l=s("60a3"),g=s("4bb5"),d=s("dfaf");function b(t){var e=y();return function(){var s,i=Object(u["a"])(t);if(e){var a=Object(u["a"])(this).constructor;s=Reflect.construct(i,arguments,a)}else s=i.apply(this,arguments);return Object(o["a"])(this,s)}}function y(){if("undefined"===typeof Reflect||!Reflect.construct)return!1;if(Reflect.construct.sham)return!1;if("function"===typeof Proxy)return!0;try{return Date.prototype.toString.call(Reflect.construct(Date,[],(function(){}))),!0}catch(t){return!1}}l["a"].registerHooks(["beforeRouteEnter"]);var m=function(t){Object(c["a"])(s,t);var e=b(s);function s(){var t;return Object(n["a"])(this,s),t=e.apply(this,arguments),t.iosFlag=!1,t.isPageHide=!1,t}return Object(r["a"])(s,[{key:"created",value:function(){this.iosFlag=Object(d["a"])()}},{key:"beforeRouteEnter",value:function(t,e,s){console.log(e.path,t)}},{key:"onClickLeft",value:function(){var t=this.routes,e=t[t.length-2];t.pop(),e&&this.$router.push(e),this.set_history(t)}},{key:"reload",value:function(){this.isPageHide&&window.location.reload()}},{key:"unReload",value:function(){this.isPageHide=!0}}]),s}(l["c"]);Object(f["__decorate"])([Object(l["b"])()],m.prototype,"title",void 0),Object(f["__decorate"])([Object(g["a"])("history")],m.prototype,"routes",void 0),Object(f["__decorate"])([Object(g["b"])("SET_HISTORY")],m.prototype,"set_history",void 0),m=Object(f["__decorate"])([l["a"]],m);var h=m,v=h,M=(s("ff74"),s("2877")),p=Object(M["a"])(v,i,a,!1,null,"23555296",null);e["a"]=p.exports},"53d1":function(t,e,s){"use strict";s.r(e);var i=function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{staticClass:"notification-message"},[i("back-title",{attrs:{title:t.$t("home.notificationMessage")},scopedSlots:t._u([{key:"search",fn:function(){return[i("van-button",{attrs:{disabled:0==t.messageList.length}},[i("van-icon",{attrs:{name:"delete",size:"25"},on:{click:t.empty}})],1)]},proxy:!0}])}),t.messageList.length>0?i("van-list",t._l(t.messageList,(function(e,s){return i("van-cell",{key:s},[i("div",{staticClass:"noti-tit-wrap"},[i("div",{staticClass:"noti-tit-text"},[i("div",{staticClass:"noti-tag"}),i("div",{staticClass:"noti-type"},[t._v(t._s(t._f("notificationType")(e.msgType)))]),i("div",{staticClass:"noti-tit-time"},[t._v(t._s(e.receivedTime))])]),i("div",{staticClass:"noti-title"},[t._v(t._s(e.msgTittle))])]),i("div",{staticClass:"noti-cont-text"},[t._v(t._s(e.msgContent))])])})),1):i("img",{staticClass:"noContentImg",attrs:{src:s("5705"),alt:"無公告背景圖標"}})],1)},a=[],n=(s("2397"),s("6b54"),s("ac6a"),s("d4ec")),r=s("bee2"),c=s("262e"),o=s("99de"),u=s("7e84"),f=s("9ab4"),l=s("60a3"),g=s("fc84"),d=s("e2c6"),b=s("da3f"),y=s("1274"),m=s("ca6f"),h=s("2241");function v(t){var e=M();return function(){var s,i=Object(u["a"])(t);if(e){var a=Object(u["a"])(this).constructor;s=Reflect.construct(i,arguments,a)}else s=i.apply(this,arguments);return Object(o["a"])(this,s)}}function M(){if("undefined"===typeof Reflect||!Reflect.construct)return!1;if(Reflect.construct.sham)return!1;if("function"===typeof Proxy)return!0;try{return Date.prototype.toString.call(Reflect.construct(Date,[],(function(){}))),!0}catch(t){return!1}}var p=function(t){Object(c["a"])(s,t);var e=v(s);function s(){var t;return Object(n["a"])(this,s),t=e.apply(this,arguments),t.messageList=[],t.userInfo={},t}return Object(r["a"])(s,[{key:"mounted",value:function(){this.userInfo=JSON.parse(localStorage.getItem("userInfo")),this.getNotificationMsg(),this.receivedMsg()}},{key:"receivedMsg",value:function(){var t=this;m["a"].subscribe(b["a"].drillDueNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].drillTimeOutNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].drillStatusNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].drillVolunteerStatusNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].drillFeedBackNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].taskDueNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].taskTimeOutNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].taskStatusNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].taskVolunteerStatusNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].taskFeedBackNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].activityDueNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].activityTimeOutNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].activityStatusNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].activityVolunteerStatusNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].activityFeedBackNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].trainVolunteerStatusNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].taskStatusNotification,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].volunteerPass,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].volunteerReject,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].adminAddVolunteerToTeam,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].adminKickoutVolunteerFromTeam,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].adminCheckVolunteerExitTask,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].adminKickoutVolunteerFromTask,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()})),m["a"].subscribe(b["a"].adminChangeTaskLeader,"",(function(e){t.messageList.unshift(t.analysisMsg(e)),t.filterMsgByUserId()}))}},{key:"getNotificationMsg",value:function(){var t=this,e=g["localstorageHelper"].readObject("notification-message");e&&e.forEach((function(e){t.messageList.unshift(e),t.filterMsgByUserId()}))}},{key:"analysisMsg",value:function(t){var e=new d["a"];return e.msgId=t.msgId,e.msgTittle=t.from,e.msgContent=t.content,e.receivedTime=t.receivedTime,e.userId=t.registerId,e.msgType=t.extend.hub,e}},{key:"empty",value:function(){var t=this;h["a"].confirm({title:this.$t("common.allDelete").toString(),message:this.$t("common.pleaseSureAllSure").toString(),confirmButtonText:this.$t("common.confirm").toString(),cancelButtonText:this.$t("common.cancel").toString()}).then((function(){var e=g["localstorageHelper"].readObject("notification-message"),s=e.filter((function(e){return e.userId!==t.userInfo.accountId}));g["localstorageHelper"].writeObject("notification-message",s),t.messageList=[]})).catch((function(){}))}},{key:"filterMsgByUserId",value:function(){var t=this;this.messageList=this.messageList.filter((function(e){return e.userId===t.userInfo.id}))}}]),s}(l["c"]);p=Object(f["__decorate"])([Object(l["a"])({components:{BackTitle:y["a"]}})],p);var I=p,k=I,L=(s("087c"),s("2877")),B=Object(L["a"])(k,i,a,!1,null,"40833ba2",null);e["default"]=B.exports},5705:function(t,e,s){t.exports=s.p+"img/noMsg-bg.c0116016.png"},dda7:function(t,e,s){},ff74:function(t,e,s){"use strict";var i=s("04f8"),a=s.n(i);a.a}}]);