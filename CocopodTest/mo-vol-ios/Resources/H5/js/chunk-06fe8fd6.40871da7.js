(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-06fe8fd6"],{4330:function(t,e,n){"use strict";n.r(e);var a=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"detail-container"},[n("back-title",{attrs:{title:t.$t("home.myTrain")}}),n("div",{staticClass:"wrapper"},[n("van-tabs",{attrs:{active:t.active,"title-active-color":"#0A886D",color:"#0A886D",swipeable:""},on:{click:t.onChange}},[n("van-tab",{attrs:{title:t.$t("train.details")}},[n("div",{staticClass:"detail-wrapper"},[n("div",{staticClass:"detail-header border-bottom"},[n("div",{staticClass:"item-detail"},[n("span",{staticClass:"desc"},[t._v(t._s(t.$t("train.name")))]),n("span",{staticClass:"detail"},[t._v(t._s(t.train.name))])]),n("div",{staticClass:"item-detail"},[n("span",{staticClass:"desc"},[t._v(t._s(t.$t("train.type")))]),n("span",{staticClass:"detail"},[t._v(t._s(t.trainType))])]),n("div",{staticClass:"item-detail"},[n("span",{staticClass:"desc"},[t._v(t._s(t.$t("train.agency")))]),n("span",{staticClass:"detail"},[t._v(t._s(t.agency))])]),n("div",{staticClass:"item-detail"},[n("span",{staticClass:"desc"},[t._v(t._s(t.$t("train.location")))]),n("span",{staticClass:"detail"},[t._v(t._s(t.train.address))])])]),n("div",{staticClass:"detail-content border-bottom"},[n("div",{staticClass:"item-detail"},[n("span",{staticClass:"desc"},[t._v(t._s(t.$t("train.planStartTime")))]),t.train.startTime?n("span",{staticClass:"detail"},[t._v(t._s(t._f("date")(t.train.startTime)))]):t._e()]),n("div",{staticClass:"item-detail"},[n("span",{staticClass:"desc"},[t._v(t._s(t.$t("train.planEndTime")))]),t.train.endTime?n("span",{staticClass:"detail"},[t._v(t._s(t._f("date")(t.train.endTime)))]):t._e()]),n("div",{staticClass:"item-detail"},[n("span",{staticClass:"desc"},[t._v(t._s(t.$t("train.teacher")))]),n("span",{staticClass:"detail"},[t._v(t._s(t.train.trainTeach))])]),n("div",{staticClass:"item-detail"},[n("span",{staticClass:"desc"},[t._v(t._s(t.$t("train.skillTag")))]),n("span",{staticClass:"detail"},[t._v(t._s(t.train.tagNames))])]),n("div",{staticClass:"item-detail"},[n("span",{staticClass:"desc"},[t._v(t._s(t.$t("train.contractPerson")))]),n("span",{staticClass:"detail"},[t._v(t._s(t.train.contactPerson))])]),n("div",{staticClass:"item-detail"},[n("span",{staticClass:"desc"},[t._v(t._s(t.$t("train.contractPersonPhone")))]),n("span",{staticClass:"detail"},[t._v(t._s(t.train.contactPersonPhone))])]),n("div",{staticClass:"item-detail"},[n("span",{staticClass:"desc"},[t._v(t._s(t.$t("train.startTime")))]),t.train.trainStartTime?n("span",{staticClass:"detail"},[t._v(t._s(t._f("date")(t.train.trainStartTime)))]):t._e()]),n("div",{staticClass:"item-detail"},[n("span",{staticClass:"desc"},[t._v(t._s(t.$t("train.endTime")))]),t.train.trainEndTime?n("span",{staticClass:"detail"},[t._v(t._s(t._f("date")(t.train.trainEndTime)))]):t._e()])]),n("div",{staticClass:"detail-footer border-bottom"},[n("div",{staticClass:"desc"},[t._v(t._s(t.$t("train.content")))]),n("div",{staticClass:"content",domProps:{innerHTML:t._s(t.train.content)}}),n("div",{staticClass:"desc"},[t._v(t._s(t.$t("common.attach")))]),n("attach",{attrs:{alienAttachModels:t.train.alienAttachModels}})],1),n("div",{staticClass:"detail-footer"},[n("div",{staticClass:"desc"},[t._v(t._s(t.$t("common.class")))]),n("div",{staticClass:"radio-group"},[n("van-radio-group",{model:{value:t.timeRadio,callback:function(e){t.timeRadio=e},expression:"timeRadio"}},t._l(t.train.trainSlotRModels,(function(e,a){return n("van-radio",{key:e.id,staticClass:"radio",attrs:{name:a+1}},[n("div",{staticClass:"class-wrapper"},[n("div",{staticClass:"className"},[t._v(t._s(t.$t("common.class"))+t._s(a+1))]),n("div",{staticClass:"classContent"},[n("div",{staticClass:"startTime"},[n("span",{staticClass:"time-desc"},[t._v("\n                          "+t._s(t.$t("train.planStartTime"))+"\n                        ")]),e.expectStartTime?n("span",[t._v("\n                          "+t._s(t._f("date")(e.expectStartTime))+"\n                        ")]):t._e()]),n("div",{staticClass:"endTime"},[n("span",{staticClass:"time-desc"},[t._v("\n                          "+t._s(t.$t("train.planEndTime"))+"\n                        ")]),e.expectEndTime?n("span",[t._v("\n                          "+t._s(t._f("date")(e.expectEndTime))+"\n                        ")]):t._e()])])])])})),1)],1)])]),"1"===t.train.status||"2"===t.train.status?n("div",{staticClass:"detail-status"},["0"===t.volunteerStatus?n("div",{staticClass:"apply only-sign",on:{click:t.applyTrain}},[t._v("\n            "+t._s(t.$t("drill.wantSignUp"))+"\n          ")]):t._e(),"2"===t.volunteerStatus?n("div",{staticClass:"check"},[n("div",{staticClass:"checking"},[t._v("\n              "+t._s(t.$t("drill.underReview"))+"\n            ")]),n("div",{staticClass:"undo",on:{click:t.cancelApplyTrain}},[t._v("\n              "+t._s(t.$t("drill.cancelApplication"))+"\n            ")])]):t._e(),"4"===t.volunteerStatus?n("div",{staticClass:"invited"},[n("div",{staticClass:"passed-invite"},[t._v("\n              "+t._s(t.$t("drill.passedInvitation"))+"\n            ")]),t.applyExitFlag?n("div",{staticClass:"reject-invite"},[t._v("\n                "+t._s(t.$t("task.applyExiting"))+"\n              ")]):n("div",{staticClass:"reject-invite",on:{click:t.applyExitTrain}},[t._v("\n                "+t._s(t.$t("task.applyExit"))+"\n              ")])]):t._e(),"1"===t.volunteerStatus?n("div",{staticClass:"invited"},[n("div",{staticClass:"pass-invite",on:{click:t.confirm}},[t._v("\n              "+t._s(t.$t("drill.acceptInvitation"))+"\n            ")]),n("div",{staticClass:"reject-invite",on:{click:t.reject}},[t._v("\n              "+t._s(t.$t("drill.rejectInvitation"))+"\n            ")])]):t._e(),"5"===t.volunteerStatus?n("div",{staticClass:"submit",class:{rejectedBg:"5"===t.volunteerStatus}},[t._v("\n            "+t._s(t.$t("drill.rejectedInvitation"))+"\n          ")]):t._e()]):t._e()]),n("van-tab",{attrs:{title:t.$t("drill.personList")}},[n("PersonList")],1),n("van-tab",{attrs:{title:t.$t("train.feedBack")}},[n("feed-back")],1)],1)],1)],1)},i=[],r=(n("2397"),n("6b54"),n("96cf"),n("1da1")),s=n("d4ec"),c=n("bee2"),o=n("262e"),u=n("99de"),l=n("7e84"),d=n("9ab4"),v=n("60a3"),p=n("4bb5"),f=n("1274"),h=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"person-container"},[t._l(t.volunteerList,(function(e,i){return a("div",{key:i,staticClass:"person-detail"},[t._m(0,!0),a("div",{staticClass:"name-wrapper"},[a("div",{staticClass:"name"},[t._v(t._s(t.$t("mine.name"))+" "+t._s(e.name))]),"1"===e.trainAttendFlag?a("div",{staticClass:"status"},[t._v(t._s(t.$t("drill.signed")))]):t._e(),e.trainAttendFlag&&"0"!==e.trainAttendFlag?t._e():a("div",{staticClass:"status"},[t._v(t._s(t.$t("drill.noSign")))])]),a("div",{staticClass:"icon-wrapper"},[a("div",{staticClass:"join-icon"},[a("img",{staticClass:"icon",attrs:{alt:"電話圖標",src:n("22b3")},on:{click:function(n){return t.callPhone(e)}}})])])])})),a("div",{staticClass:"sign"},["0"===t.trainDetail.taskAttendFlag?a("div",{staticClass:"btn1 only-sign",on:{click:t.signTrain}},[t._v(t._s(t.$t("common.sign")))]):t._e(),"1"===t.trainDetail.taskAttendFlag?a("div",{staticClass:"btn1 completeBg",on:{click:t.finish}},[t._v(t._s(t.$t("common.signed")))]):t._e()])],2)},m=[function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"avatar-wrapper"},[a("img",{staticClass:"icon",attrs:{alt:"頭像",src:n("6837")}})])}],b=n("0957"),g=n("e7df"),_=n("c1c5"),y=n("69a9"),j=n("2241");function k(t){var e=O();return function(){var n,a=Object(l["a"])(t);if(e){var i=Object(l["a"])(this).constructor;n=Reflect.construct(a,arguments,i)}else n=a.apply(this,arguments);return Object(u["a"])(this,n)}}function O(){if("undefined"===typeof Reflect||!Reflect.construct)return!1;if(Reflect.construct.sham)return!1;if("function"===typeof Proxy)return!0;try{return Date.prototype.toString.call(Reflect.construct(Date,[],(function(){}))),!0}catch(t){return!1}}var C=function(t){Object(o["a"])(n,t);var e=k(n);function n(){var t;return Object(s["a"])(this,n),t=e.apply(this,arguments),t.trainvolunteerParam=new y["a"],t.volunteerList=[],t.count=0,t.volunteerId="",t}return Object(c["a"])(n,[{key:"created",value:function(){this.initTrainvolunteer(),this.getPersonList()}},{key:"getPersonList",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return this.trainvolunteerParam.volunteerId="",t.next=3,Object(_["m"])(this.trainvolunteerParam);case 3:e=t.sent,this.volunteerList=e.data.filter((function(t){return"4"===t.taskTakeStatus})),this.count=this.volunteerList.length;case 6:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"initTrainvolunteer",value:function(){this.trainvolunteerParam.trainId=this.trainDetail.id;var t=JSON.parse(localStorage.getItem("userInfo"));t&&(this.volunteerId=t.id)}},{key:"signTrain",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e=this;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:j["a"].confirm({message:this.$t("drill.sureSign").toString(),confirmButtonText:this.$t("common.confirm").toString(),cancelButtonText:this.$t("common.cancel").toString()}).then((function(){e._sign()}));case 1:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"_sign",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e,n;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:if("2"!==this.trainDetail.status){t.next=9;break}return this.trainvolunteerParam.volunteerId=this.volunteerId,t.next=4,Object(_["o"])(this.trainvolunteerParam);case 4:e=t.sent,console.log(e.success),e.success&&(n=Object.assign({},this.trainDetail),n.taskAttendFlag="1",this.SET_TRAIN(n),this.getPersonList()),t.next=10;break;case 9:Object(g["a"])(this.$t("drill.noInProgressNotSign").toString());case 10:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"finish",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:Object(g["a"])(this.$t("common.signed").toString());case 1:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"_finish",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e,n;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:if("2"!==this.trainDetail.status){t.next=8;break}return this.trainvolunteerParam.volunteerId=this.volunteerId,t.next=4,Object(_["f"])(this.trainvolunteerParam);case 4:e=t.sent,e.success&&(n=Object.assign({},this.trainDetail),n.taskAttendFlag="2",this.SET_TRAIN(n),this.getPersonList()),t.next=9;break;case 8:Object(g["a"])(this.$t("drill.noInProgressNotComplete").toString());case 9:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"finished",value:function(){Object(g["a"])(this.$t("drill.completedNotClick").toString())}},{key:"callPhone",value:function(t){b["call"].makePhoneCall({phoneNumber:t.phone,success:function(t){console.log("success"+t)},fail:function(t){console.log(t)}})}},{key:"rating",value:function(t){var e=arguments.length>1&&void 0!==arguments[1]?arguments[1]:"noRead";this.$router.push({path:"/rating",query:{data:t,from:"train",read:e}})}}]),n}(v["c"]);Object(d["__decorate"])([Object(p["a"])("trainDetail")],C.prototype,"trainDetail",void 0),Object(d["__decorate"])([Object(p["b"])("SET_TRAIN")],C.prototype,"SET_TRAIN",void 0),C=Object(d["__decorate"])([v["a"]],C);var x=C,T=x,w=(n("44e4"),n("2877")),S=Object(w["a"])(T,h,m,!1,null,"e6b1cefe",null),R=S.exports,$=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"person-container"},[n("div",{staticClass:"response-detail"},[n("div",{staticClass:"item-title"},[n("span",{staticClass:"rectangle"}),n("span",{staticClass:"title"},[t._v(t._s(t.$t("drill.feedBackInfo")))])]),n("van-field",{staticClass:"content",attrs:{autosize:"",rows:"4",readonly:"",type:"textarea"},model:{value:t.feedBackContent,callback:function(e){t.feedBackContent=e},expression:"feedBackContent"}})],1)])},P=[],I=(n("28a5"),n("997a")),L=n("85b4");function D(t){var e=A();return function(){var n,a=Object(l["a"])(t);if(e){var i=Object(l["a"])(this).constructor;n=Reflect.construct(a,arguments,i)}else n=a.apply(this,arguments);return Object(u["a"])(this,n)}}function A(){if("undefined"===typeof Reflect||!Reflect.construct)return!1;if(Reflect.construct.sham)return!1;if("function"===typeof Proxy)return!0;try{return Date.prototype.toString.call(Reflect.construct(Date,[],(function(){}))),!0}catch(t){return!1}}var B=function(t){Object(o["a"])(n,t);var e=D(n);function n(){var t;return Object(s["a"])(this,n),t=e.apply(this,arguments),t.feedBackParam=new y["a"],t.feedBackList=[],t.startTime="",t.endTime="",t.uploadData=[],t.videoImgs=[],t.volunteerList=[],t.videoImg="",t.fileUrl=I["a"].fileUrl+"/api/v1/attaches/upload/single",t.progress=0,t.fileId="",t.count=0,t.feedBackContent="",t}return Object(c["a"])(n,[{key:"created",value:function(){this.init(),this.getPersonList()}},{key:"mounted",value:function(){this.getFeedBackList()}},{key:"getPersonList",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return t.next=2,Object(_["m"])(this.feedBackParam);case 2:e=t.sent,this.volunteerList=e.data,this.count=this.volunteerList.length;case 5:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"init",value:function(){var t=JSON.parse(localStorage.getItem("userInfo"));t&&(this.feedBackParam.volunteerId=t.id,this.feedBackParam.volunteerName=t.name),this.feedBackParam.trainId=this.trainDetail.id}},{key:"getFeedBackList",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e,n;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return t.next=2,Object(_["k"])(this.feedBackParam);case 2:e=t.sent,n=e.data.reverse(),this.feedBackList=n;case 5:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"joinPath",value:function(t){var e=t.fileId,n=t.fileName.split("."),a=n[n.length-1],i="/storage/emulated/0/com.gsafety.mo.vol/downloads/"+e+"."+a;return i}}]),n}(v["c"]);Object(d["__decorate"])([Object(p["a"])("trainDetail")],B.prototype,"trainDetail",void 0),B=Object(d["__decorate"])([Object(v["a"])({components:{FeedBackDetail:L["a"]}})],B);var E=B,F=E,N=(n("cfae"),Object(w["a"])(F,$,P,!1,null,"07c60346",null)),V=N.exports,J=function t(){Object(s["a"])(this,t)},M=n("d83a"),U=n("b4eb"),z=n("cc14"),q=n("283c");function H(t){var e=G();return function(){var n,a=Object(l["a"])(t);if(e){var i=Object(l["a"])(this).constructor;n=Reflect.construct(a,arguments,i)}else n=a.apply(this,arguments);return Object(u["a"])(this,n)}}function G(){if("undefined"===typeof Reflect||!Reflect.construct)return!1;if(Reflect.construct.sham)return!1;if("function"===typeof Proxy)return!0;try{return Date.prototype.toString.call(Reflect.construct(Date,[],(function(){}))),!0}catch(t){return!1}}var K=function(t){Object(o["a"])(n,t);var e=H(n);function n(){var t;return Object(s["a"])(this,n),t=e.apply(this,arguments),t.active=0,t.mineStatus="",t.finishFlag=!1,t.signFlag=!1,t.train={},t.timeRadio=1,t.trainType="",t.agency="",t.trainStatus="",t.volunteer=new M["a"](""),t.trainVolunteer=new J,t.trainvolunteerParam=new y["a"],t.volunteerStatus="",t.applyExitFlag=!1,t}return Object(c["a"])(n,[{key:"created",value:function(){this.init();var t=JSON.parse(localStorage.getItem("userInfo"));this.volunteer.id=t.id,this.trainVolunteer.volunteerModels=[this.volunteer],this.trainVolunteer.trainId=this.trainDetail.id,this.trainvolunteerParam.trainId=this.trainDetail.id,this.trainvolunteerParam.volunteerId=t.id}},{key:"init",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e,n,a;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return e=localStorage.getItem("trainStatus"),e&&(this.trainStatus=e),t.next=4,Object(_["j"])(this.trainDetail.id);case 4:n=t.sent,a=n.data,this.train=a,this.getTrainType(),this.getAgencyInfo(),this.getVolunteerStatus(),this.exitPersonList();case 11:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"onChange",value:function(){}},{key:"getVolunteerStatus",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e,n;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return t.next=2,Object(_["m"])(this.trainvolunteerParam);case 2:e=t.sent,n=e.data,n.length>0?this.volunteerStatus=n[0].taskTakeStatus:this.volunteerStatus="0";case 5:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"exitPersonList",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e,n,a=this;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return t.next=2,Object(_["e"])(this.trainDetail.id);case 2:e=t.sent,n=e.data,this.applyExitFlag=n.some((function(t){return t.id===a.volunteer.id}));case 5:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"getTrainType",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e,n;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return t.next=2,Object(z["o"])(this.train.typeCode);case 2:e=t.sent,n=e.data,this.trainType=n[0].name;case 5:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"getAgencyInfo",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e,n;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return t.next=2,Object(z["j"])(this.train.agencyCode);case 2:e=t.sent,n=e.data,this.agency=n.name;case 5:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"confirm",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e,n,a,i;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return e=this.$t("common.train").toString(),t.next=3,Object(q["a"])(this.$t("common.sureAcceptInvitation",{preffix:e}).toString());case 3:if(n=t.sent,"confirm"!==n){t.next=10;break}return t.next=7,Object(_["d"])(this.trainVolunteer);case 7:a=t.sent,i=a.success,i&&this.getVolunteerStatus();case 10:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"reject",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e,n,a,i;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return e=this.$t("common.train").toString(),t.next=3,Object(q["a"])(this.$t("common.sureRejectInvitation",{preffix:e}).toString());case 3:if(n=t.sent,"confirm"!==n){t.next=10;break}return t.next=7,Object(_["n"])(this.trainVolunteer);case 7:a=t.sent,i=a.success,i&&this.getVolunteerStatus();case 10:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"applyTrain",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e,n,a,i,r;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return e=this.train.trainSlotRModels[this.timeRadio-1].id,this.trainVolunteer.slotId=e,n=this.$t("common.train").toString(),t.next=5,Object(q["a"])(this.$t("common.sureApplyJoin",{preffix:n}).toString());case 5:if(a=t.sent,"confirm"!==a){t.next=12;break}return t.next=9,Object(_["b"])(this.trainVolunteer);case 9:i=t.sent,r=i.success,r&&this.getVolunteerStatus();case 12:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"applyExitTrain",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e,n,a;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return t.next=2,Object(q["a"])(this.$t("task.applyExit").toString()+this.$t("common.train").toString());case 2:if(e=t.sent,"confirm"!==e){t.next=9;break}return t.next=6,Object(_["a"])(this.trainDetail.id,this.volunteer.id);case 6:n=t.sent,a=n.success,a&&this.exitPersonList();case 9:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()},{key:"cancelApplyTrain",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var e,n,a,i;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return e=this.$t("common.train").toString(),t.next=3,Object(q["a"])(this.$t("common.sureCancelApply",{preffix:e}).toString());case 3:if(n=t.sent,"confirm"!==n){t.next=10;break}return t.next=7,Object(_["c"])(this.trainVolunteer);case 7:a=t.sent,i=a.success,i&&this.getVolunteerStatus();case 10:case"end":return t.stop()}}),t,this)})));function e(){return t.apply(this,arguments)}return e}()}]),n}(v["c"]);Object(d["__decorate"])([Object(p["a"])("trainDetail")],K.prototype,"trainDetail",void 0),K=Object(d["__decorate"])([Object(v["a"])({components:{BackTitle:f["a"],PersonList:R,FeedBack:V,Attach:U["a"]}})],K);var Q=K,W=Q,X=(n("e928"),Object(w["a"])(W,a,i,!1,null,"6b48efe1",null));e["default"]=X.exports},"44e4":function(t,e,n){"use strict";var a=n("dac0"),i=n.n(a);i.a},"69a9":function(t,e,n){"use strict";n.d(e,"a",(function(){return i}));var a=n("d4ec"),i=function t(){Object(a["a"])(this,t)}},9621:function(t,e,n){"use strict";var a=n("acc9"),i=n.n(a);i.a},acc9:function(t,e,n){},b4eb:function(t,e,n){"use strict";var a=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"attach-container"},[n("ul",{staticClass:"attach-wrapper"},t._l(t.alienAttachModels,(function(e){return n("li",{key:e.id,staticClass:"attach-item",on:{click:function(n){return t.openFile(e)}}},[t._v("\n      "+t._s(e.fileName)+"\n    ")])})),0)])},i=[],r=(n("6b54"),n("2397"),n("d4ec")),s=n("bee2"),c=n("262e"),o=n("99de"),u=n("7e84"),l=n("9ab4"),d=n("60a3"),v=n("77262");function p(t){var e=f();return function(){var n,a=Object(u["a"])(t);if(e){var i=Object(u["a"])(this).constructor;n=Reflect.construct(a,arguments,i)}else n=a.apply(this,arguments);return Object(o["a"])(this,n)}}function f(){if("undefined"===typeof Reflect||!Reflect.construct)return!1;if(Reflect.construct.sham)return!1;if("function"===typeof Proxy)return!0;try{return Date.prototype.toString.call(Reflect.construct(Date,[],(function(){}))),!0}catch(t){return!1}}var h=function(t){Object(c["a"])(n,t);var e=p(n);function n(){return Object(r["a"])(this,n),e.apply(this,arguments)}return Object(s["a"])(n,[{key:"openFile",value:function(t){Object(v["a"])(t)}}]),n}(d["c"]);Object(l["__decorate"])([Object(d["b"])()],h.prototype,"alienAttachModels",void 0),h=Object(l["__decorate"])([d["a"]],h);var m=h,b=m,g=(n("9621"),n("2877")),_=Object(g["a"])(b,a,i,!1,null,"675f7c5d",null);e["a"]=_.exports},c1c5:function(t,e,n){"use strict";n.d(e,"o",(function(){return o})),n.d(e,"g",(function(){return u})),n.d(e,"i",(function(){return l})),n.d(e,"h",(function(){return d})),n.d(e,"f",(function(){return v})),n.d(e,"m",(function(){return p})),n.d(e,"k",(function(){return f})),n.d(e,"l",(function(){return h})),n.d(e,"j",(function(){return m})),n.d(e,"b",(function(){return b})),n.d(e,"n",(function(){return g})),n.d(e,"d",(function(){return _})),n.d(e,"a",(function(){return y})),n.d(e,"c",(function(){return j})),n.d(e,"e",(function(){return k}));var a=n("f39e"),i=n("997a"),r={getTrainScore:"/app/train/volunteer/getScore",addTrainFeedback:"/app/train/feedback/add",getTrainList:"/app/train/volunteer/list/all",getAllTrainList:"/app/train/page/listByUserId?",getJoinedListBypage:"/app/train/page/trainJoinedList?",getJoinedList:"/app/train/trainJoinedList",getTrainFeedBack:"/app/train/feedback/list",addTrainScore:"/app/train/volunteer/score",getTrain:"/app/train/get/",applyTrain:"/app/train/volunteer/apply",rejectTrain:"/app/train/volunteer/reject",confirmTrain:"/app/train/volunteer/confirm",applyExitTrain:"/app/train/volunteer/exit/apply",canceljoinTrain:"/app/train/volunteer/apply/cancel",exitList:"/app/train/volunteer/exit/list"},s=r,c=i["a"].baseUrl;function o(t){var e=c+"/app/train/volunteer/sign";return Object(a["b"])(e,t)}function u(t,e,n){var i=c+s.getAllTrainList+"rows="+n+"&page="+e;return Object(a["b"])(i,t)}function l(t,e,n){var i=c+s.getJoinedListBypage+"rows="+n+"&page="+e;return Object(a["b"])(i,t)}function d(t){var e=c+s.getJoinedList;return Object(a["b"])(e,t)}function v(t){var e=c+"/app/train/volunteer/finish";return Object(a["b"])(e,t)}function p(t){var e=c+s.getTrainList;return Object(a["b"])(e,t)}function f(t){var e=c+s.getTrainFeedBack;return Object(a["b"])(e,t)}function h(t){var e=c+s.getTrainScore;return Object(a["b"])(e,t)}function m(t){var e=c+s.getTrain+t;return Object(a["a"])(e)}function b(t){var e=c+s.applyTrain;return Object(a["b"])(e,t)}function g(t){var e=c+s.rejectTrain;return Object(a["b"])(e,t)}function _(t){var e=c+s.confirmTrain;return Object(a["b"])(e,t)}function y(t,e){var n=c+s.applyExitTrain;return Object(a["b"])(n,{bizId:t,volunteerId:e})}function j(t){var e=c+s.canceljoinTrain;return Object(a["b"])(e,t)}function k(t){var e=c+s.exitList;return Object(a["b"])(e,{trainId:t})}},cfae:function(t,e,n){"use strict";var a=n("d137"),i=n.n(a);i.a},d137:function(t,e,n){},dac0:function(t,e,n){},e928:function(t,e,n){"use strict";var a=n("e9bd"),i=n.n(a);i.a},e9bd:function(t,e,n){}}]);