(()=>{var $={};function ge(e){$.context=e}function qe(){return{...$.context,id:`${$.context.id}${$.context.count++}-`,count:0}}var je=(e,t)=>e===t,ct=Symbol("solid-proxy"),Ie=Symbol("solid-track"),De=Symbol("solid-dev-component"),Z={equals:je},me=null,He=ke,P=1,V=2,xe={owned:null,cleanups:null,context:null,owner:null},ie={},p=null,l=null,Y=null,se=null,y=null,k=null,L=null,te=0,[ft,pe]=O(!1);function Q(e,t){let n=y,r=p,i=e.length===0,s=i?xe:{owned:null,cleanups:null,context:null,owner:t===void 0?r:t},a=i?e:()=>e(()=>H(()=>R(s)));p=s,y=null;try{return j(a,!0)}finally{y=n,p=r}}function O(e,t){t=t?Object.assign({},Z,t):Z;let n={value:e,observers:null,observerSlots:null,comparator:t.equals||void 0},r=i=>(typeof i=="function"&&(l&&l.running&&l.sources.has(n)?i=i(n.tValue):i=i(n.value)),$e(n,i));return[Se.bind(n),r]}function be(e,t,n){let r=ce(e,t,!0,P);Y&&l&&l.running?k.push(r):J(r)}function N(e,t,n){let r=ce(e,t,!1,P);Y&&l&&l.running?k.push(r):J(r)}function K(e,t,n){n=n?Object.assign({},Z,n):Z;let r=ce(e,t,!0,0);return r.observers=null,r.observerSlots=null,r.comparator=n.equals||void 0,Y&&l&&l.running?(r.tState=P,k.push(r)):J(r),Se.bind(r)}function ae(e,t,n){let r,i,s;arguments.length===2&&typeof t=="object"||arguments.length===1?(r=!0,i=e,s=t||{}):(r=e,i=t,s=n||{});let a=null,o=ie,f=null,c=!1,u=!1,g="initialValue"in s,w=typeof r=="function"&&K(r),d=new Set,[m,C]=(s.storage||O)(s.initialValue),[v,T]=O(void 0),[F,h]=O(void 0,{equals:!1}),[x,_]=O(g?"ready":"unresolved");if($.context){f=`${$.context.id}${$.context.count++}`;let b;s.ssrLoadFrom==="initial"?o=s.initialValue:$.load&&(b=$.load(f))&&(o=b[0])}function q(b,S,E,z){return a===b&&(a=null,g=!0,(b===o||S===o)&&s.onHydrated&&queueMicrotask(()=>s.onHydrated(z,{value:S})),o=ie,l&&b&&c?(l.promises.delete(b),c=!1,j(()=>{l.running=!0,W(S,E)},!1)):W(S,E)),S}function W(b,S){j(()=>{S===void 0&&C(()=>b),_(S!==void 0?"errored":"ready"),T(S);for(let E of d.keys())E.decrement();d.clear()},!1)}function U(){let b=oe&&de(p,oe.id),S=m(),E=v();if(E!==void 0&&!a)throw E;return y&&!y.user&&b&&be(()=>{F(),a&&(b.resolved&&l&&c?l.promises.add(a):d.has(b)||(b.increment(),d.add(b)))}),S}function G(b=!0){if(b!==!1&&u)return;u=!1;let S=w?w():r;if(c=l&&l.running,S==null||S===!1){q(a,H(m));return}l&&a&&l.promises.delete(a);let E=o!==ie?o:H(()=>i(S,{value:m(),refetching:b}));return typeof E!="object"||!(E&&"then"in E)?(q(a,E,void 0,S),E):(a=E,u=!0,queueMicrotask(()=>u=!1),j(()=>{_(g?"refreshing":"pending"),h()},!1),E.then(z=>q(E,z,void 0,S),z=>q(E,void 0,Ae(z),S)))}return Object.defineProperties(U,{state:{get:()=>x()},error:{get:()=>v()},loading:{get(){let b=x();return b==="pending"||b==="refreshing"}},latest:{get(){if(!g)return U();let b=v();if(b&&!a)throw b;return m()}}}),w?be(()=>G(!1)):G(!1),[U,{refetch:G,mutate:C}]}function H(e){if(y===null)return e();let t=y;y=null;try{return e()}finally{y=t}}function ue(e){return p===null||(p.cleanups===null?p.cleanups=[e]:p.cleanups.push(e)),e}function Ve(e){if(l&&l.running)return e(),l.done;let t=y,n=p;return Promise.resolve().then(()=>{y=t,p=n;let r;return(Y||oe)&&(r=l||(l={sources:new Set,effects:[],promises:new Set,disposed:new Set,queue:new Set,running:!0}),r.done||(r.done=new Promise(i=>r.resolve=i)),r.running=!0),j(e,!1),y=p=null,r?r.done:void 0})}function Re(e,t){let n=Symbol("context");return{id:n,Provider:Ge(n),defaultValue:e}}function We(e){let t=K(e),n=K(()=>le(t()));return n.toArray=()=>{let r=n();return Array.isArray(r)?r:r!=null?[r]:[]},n}var oe;function Se(){let e=l&&l.running;if(this.sources&&(!e&&this.state||e&&this.tState))if(!e&&this.state===P||e&&this.tState===P)J(this);else{let t=k;k=null,j(()=>ee(this),!1),k=t}if(y){let t=this.observers?this.observers.length:0;y.sources?(y.sources.push(this),y.sourceSlots.push(t)):(y.sources=[this],y.sourceSlots=[t]),this.observers?(this.observers.push(y),this.observerSlots.push(y.sources.length-1)):(this.observers=[y],this.observerSlots=[y.sources.length-1])}return e&&l.sources.has(this)?this.tValue:this.value}function $e(e,t,n){let r=l&&l.running&&l.sources.has(e)?e.tValue:e.value;if(!e.comparator||!e.comparator(r,t)){if(l){let i=l.running;(i||!n&&l.sources.has(e))&&(l.sources.add(e),e.tValue=t),i||(e.value=t)}else e.value=t;e.observers&&e.observers.length&&j(()=>{for(let i=0;i<e.observers.length;i+=1){let s=e.observers[i],a=l&&l.running;a&&l.disposed.has(s)||((a&&!s.tState||!a&&!s.state)&&(s.pure?k.push(s):L.push(s),s.observers&&Ce(s)),a?s.tState=P:s.state=P)}if(k.length>1e6)throw k=[],new Error},!1)}return t}function J(e){if(!e.fn)return;R(e);let t=p,n=y,r=te;y=p=e,ye(e,l&&l.running&&l.sources.has(e)?e.tValue:e.value,r),l&&!l.running&&l.sources.has(e)&&queueMicrotask(()=>{j(()=>{l&&(l.running=!0),y=p=e,ye(e,e.tValue,r),y=p=null},!1)}),y=n,p=t}function ye(e,t,n){let r;try{r=e.fn(t)}catch(i){return e.pure&&(l&&l.running?(e.tState=P,e.tOwned&&e.tOwned.forEach(R),e.tOwned=void 0):(e.state=P,e.owned&&e.owned.forEach(R),e.owned=null)),e.updatedAt=n+1,Ee(i)}(!e.updatedAt||e.updatedAt<=n)&&(e.updatedAt!=null&&"observers"in e?$e(e,r,!0):l&&l.running&&e.pure?(l.sources.add(e),e.tValue=r):e.value=r,e.updatedAt=n)}function ce(e,t,n,r=P,i){let s={fn:e,state:r,updatedAt:null,owned:null,sources:null,sourceSlots:null,cleanups:null,value:t,owner:p,context:null,pure:n};if(l&&l.running&&(s.state=0,s.tState=r),p===null||p!==xe&&(l&&l.running&&p.pure?p.tOwned?p.tOwned.push(s):p.tOwned=[s]:p.owned?p.owned.push(s):p.owned=[s]),se){let[a,o]=O(void 0,{equals:!1}),f=se(s.fn,o);ue(()=>f.dispose());let c=()=>Ve(o).then(()=>u.dispose()),u=se(s.fn,c);s.fn=g=>(a(),l&&l.running?u.track(g):f.track(g))}return s}function fe(e){let t=l&&l.running;if(!t&&e.state===0||t&&e.tState===0)return;if(!t&&e.state===V||t&&e.tState===V)return ee(e);if(e.suspense&&H(e.suspense.inFallback))return e.suspense.effects.push(e);let n=[e];for(;(e=e.owner)&&(!e.updatedAt||e.updatedAt<te);){if(t&&l.disposed.has(e))return;(!t&&e.state||t&&e.tState)&&n.push(e)}for(let r=n.length-1;r>=0;r--){if(e=n[r],t){let i=e,s=n[r+1];for(;(i=i.owner)&&i!==s;)if(l.disposed.has(i))return}if(!t&&e.state===P||t&&e.tState===P)J(e);else if(!t&&e.state===V||t&&e.tState===V){let i=k;k=null,j(()=>ee(e,n[0]),!1),k=i}}}function j(e,t){if(k)return e();let n=!1;t||(k=[]),L?n=!0:L=[],te++;try{let r=e();return Be(n),r}catch(r){n||(L=null),k=null,Ee(r)}}function Be(e){if(k&&(Y&&l&&l.running?Ue(k):ke(k),k=null),e)return;let t;if(l){if(!l.promises.size&&!l.queue.size){let r=l.sources,i=l.disposed;L.push.apply(L,l.effects),t=l.resolve;for(let s of L)"tState"in s&&(s.state=s.tState),delete s.tState;l=null,j(()=>{for(let s of i)R(s);for(let s of r){if(s.value=s.tValue,s.owned)for(let a=0,o=s.owned.length;a<o;a++)R(s.owned[a]);s.tOwned&&(s.owned=s.tOwned),delete s.tValue,delete s.tOwned,s.tState=0}pe(!1)},!1)}else if(l.running){l.running=!1,l.effects.push.apply(l.effects,L),L=null,pe(!0);return}}let n=L;L=null,n.length&&j(()=>He(n),!1),t&&t()}function ke(e){for(let t=0;t<e.length;t++)fe(e[t])}function Ue(e){for(let t=0;t<e.length;t++){let n=e[t],r=l.queue;r.has(n)||(r.add(n),Y(()=>{r.delete(n),j(()=>{l.running=!0,fe(n)},!1),l&&(l.running=!1)}))}}function ee(e,t){let n=l&&l.running;n?e.tState=0:e.state=0;for(let r=0;r<e.sources.length;r+=1){let i=e.sources[r];i.sources&&(!n&&i.state===P||n&&i.tState===P?i!==t&&(!i.updatedAt||i.updatedAt<te)&&fe(i):(!n&&i.state===V||n&&i.tState===V)&&ee(i,t))}}function Ce(e){let t=l&&l.running;for(let n=0;n<e.observers.length;n+=1){let r=e.observers[n];(!t&&!r.state||t&&!r.tState)&&(t?r.tState=V:r.state=V,r.pure?k.push(r):L.push(r),r.observers&&Ce(r))}}function R(e){let t;if(e.sources)for(;e.sources.length;){let n=e.sources.pop(),r=e.sourceSlots.pop(),i=n.observers;if(i&&i.length){let s=i.pop(),a=n.observerSlots.pop();r<i.length&&(s.sourceSlots[a]=r,i[r]=s,n.observerSlots[r]=a)}}if(l&&l.running&&e.pure){if(e.tOwned){for(t=0;t<e.tOwned.length;t++)R(e.tOwned[t]);delete e.tOwned}_e(e,!0)}else if(e.owned){for(t=0;t<e.owned.length;t++)R(e.owned[t]);e.owned=null}if(e.cleanups){for(t=0;t<e.cleanups.length;t++)e.cleanups[t]();e.cleanups=null}l&&l.running?e.tState=0:e.state=0,e.context=null}function _e(e,t){if(t||(e.tState=0,l.disposed.add(e)),e.owned)for(let n=0;n<e.owned.length;n++)_e(e.owned[n])}function Ae(e){return e instanceof Error||typeof e=="string"?e:new Error("Unknown error")}function we(e,t){for(let n of e)n(t)}function Ee(e){e=Ae(e);let t=me&&de(p,me);if(!t)throw e;L?L.push({fn(){we(t,e)},state:P}):we(t,e)}function de(e,t){return e?e.context&&e.context[t]!==void 0?e.context[t]:de(e.owner,t):void 0}function le(e){if(typeof e=="function"&&!e.length)return le(e());if(Array.isArray(e)){let t=[];for(let n=0;n<e.length;n++){let r=le(e[n]);Array.isArray(r)?t.push.apply(t,r):t.push(r)}return t}return e}function Ge(e,t){return function(r){let i;return N(()=>i=H(()=>(p.context={[e]:r.value},We(()=>r.children))),void 0),i}}var Ke=Symbol("fallback");function ve(e){for(let t=0;t<e.length;t++)e[t]()}function Ye(e,t,n={}){let r=[],i=[],s=[],a=0,o=t.length>1?[]:null;return ue(()=>ve(s)),()=>{let f=e()||[],c,u;return f[Ie],H(()=>{let w=f.length,d,m,C,v,T,F,h,x,_;if(w===0)a!==0&&(ve(s),s=[],r=[],i=[],a=0,o&&(o=[])),n.fallback&&(r=[Ke],i[0]=Q(q=>(s[0]=q,n.fallback())),a=1);else if(a===0){for(i=new Array(w),u=0;u<w;u++)r[u]=f[u],i[u]=Q(g);a=w}else{for(C=new Array(w),v=new Array(w),o&&(T=new Array(w)),F=0,h=Math.min(a,w);F<h&&r[F]===f[F];F++);for(h=a-1,x=w-1;h>=F&&x>=F&&r[h]===f[x];h--,x--)C[x]=i[h],v[x]=s[h],o&&(T[x]=o[h]);for(d=new Map,m=new Array(x+1),u=x;u>=F;u--)_=f[u],c=d.get(_),m[u]=c===void 0?-1:c,d.set(_,u);for(c=F;c<=h;c++)_=r[c],u=d.get(_),u!==void 0&&u!==-1?(C[u]=i[c],v[u]=s[c],o&&(T[u]=o[c]),u=m[u],d.set(_,u)):s[c]();for(u=F;u<w;u++)u in C?(i[u]=C[u],s[u]=v[u],o&&(o[u]=T[u],o[u](u))):i[u]=Q(g);i=i.slice(0,a=w),r=f.slice(0)}return i});function g(w){if(s[u]=w,o){let[d,m]=O(u);return o[u]=m,t(f[u],d)}return t(f[u])}}}var Xe=!1;function I(e,t){if(Xe&&$.context){let n=$.context;ge(qe());let r=H(()=>e(t||{}));return ge(n),r}return H(()=>e(t||{}))}function B(e){let t="fallback"in e&&{fallback:()=>e.fallback};return K(Ye(()=>e.each,e.children,t||void 0))}var dt=Re();var ze=["allowfullscreen","async","autofocus","autoplay","checked","controls","default","disabled","formnovalidate","hidden","indeterminate","ismap","loop","multiple","muted","nomodule","novalidate","open","playsinline","readonly","required","reversed","seamless","selected"],At=new Set(["className","value","readOnly","formNoValidate","isMap","noModule","playsInline",...ze]);function Qe(e,t,n){let r=n.length,i=t.length,s=r,a=0,o=0,f=t[i-1].nextSibling,c=null;for(;a<i||o<s;){if(t[a]===n[o]){a++,o++;continue}for(;t[i-1]===n[s-1];)i--,s--;if(i===a){let u=s<r?o?n[o-1].nextSibling:n[s-o]:f;for(;o<s;)e.insertBefore(n[o++],u)}else if(s===o)for(;a<i;)(!c||!c.has(t[a]))&&t[a].remove(),a++;else if(t[a]===n[s-1]&&n[o]===t[i-1]){let u=t[--i].nextSibling;e.insertBefore(n[o++],t[a++].nextSibling),e.insertBefore(n[--s],u),t[i]=n[s]}else{if(!c){c=new Map;let g=o;for(;g<s;)c.set(n[g],g++)}let u=c.get(t[a]);if(u!=null)if(o<u&&u<s){let g=a,w=1,d;for(;++g<i&&g<s&&!((d=c.get(t[g]))==null||d!==u+w);)w++;if(w>u-o){let m=t[a];for(;o<u;)e.insertBefore(n[o++],m)}else e.replaceChild(n[o++],t[a++])}else a++;else t[a++].remove()}}}var Te="_$DX_DELEGATE";function Pe(e,t,n,r={}){let i;return Q(s=>{i=s,t===document?e():A(t,e(),t.firstChild?null:void 0,n)},r.owner),()=>{i(),t.textContent=""}}function D(e,t,n){let r=document.createElement("template");if(r.innerHTML=e,t&&r.innerHTML.split("<").length-1!==t)throw`The browser resolved template HTML does not match JSX input:
${r.innerHTML}

${e}. Is your HTML properly formed?`;let i=r.content.firstChild;return n&&(i=i.firstChild),i}function re(e,t=window.document){let n=t[Te]||(t[Te]=new Set);for(let r=0,i=e.length;r<i;r++){let s=e[r];n.has(s)||(n.add(s),t.addEventListener(s,Je))}}function M(e,t,n){n==null?e.removeAttribute(t):e.setAttribute(t,n)}function A(e,t,n,r){if(n!==void 0&&!r&&(r=[]),typeof t!="function")return ne(e,t,r,n);N(i=>ne(e,t(),i,n),r)}function Je(e){let t=`$$${e.type}`,n=e.composedPath&&e.composedPath()[0]||e.target;for(e.target!==n&&Object.defineProperty(e,"target",{configurable:!0,value:n}),Object.defineProperty(e,"currentTarget",{configurable:!0,get(){return n||document}}),$.registry&&!$.done&&($.done=!0,document.querySelectorAll("[id^=pl-]").forEach(r=>{for(;r&&r.nodeType!==8&&r.nodeValue!=="pl-"+e;){let i=r.nextSibling;r.remove(),r=i}r&&r.remove()}));n;){let r=n[t];if(r&&!n.disabled){let i=n[`${t}Data`];if(i!==void 0?r.call(n,i,e):r.call(n,e),e.cancelBubble)return}n=n._$host||n.parentNode||n.host}}function ne(e,t,n,r,i){for($.context&&!n&&(n=[...e.childNodes]);typeof n=="function";)n=n();if(t===n)return n;let s=typeof t,a=r!==void 0;if(e=a&&n[0]&&n[0].parentNode||e,s==="string"||s==="number"){if($.context)return n;if(s==="number"&&(t=t.toString()),a){let o=n[0];o&&o.nodeType===3?o.data=t:o=document.createTextNode(t),n=X(e,n,r,o)}else n!==""&&typeof n=="string"?n=e.firstChild.data=t:n=e.textContent=t}else if(t==null||s==="boolean"){if($.context)return n;n=X(e,n,r)}else{if(s==="function")return N(()=>{let o=t();for(;typeof o=="function";)o=o();n=ne(e,o,n,r)}),()=>n;if(Array.isArray(t)){let o=[],f=n&&Array.isArray(n);if(he(o,t,n,i))return N(()=>n=ne(e,o,n,r,!0)),()=>n;if($.context){if(!o.length)return n;for(let c=0;c<o.length;c++)if(o[c].parentNode)return n=o}if(o.length===0){if(n=X(e,n,r),a)return n}else f?n.length===0?Fe(e,o,r):Qe(e,n,o):(n&&X(e),Fe(e,o));n=o}else if(t instanceof Node){if($.context&&t.parentNode)return n=a?[t]:t;if(Array.isArray(n)){if(a)return n=X(e,n,r,t);X(e,n,null,t)}else n==null||n===""||!e.firstChild?e.appendChild(t):e.replaceChild(t,e.firstChild);n=t}else console.warn("Unrecognized value. Skipped inserting",t)}return n}function he(e,t,n,r){let i=!1;for(let s=0,a=t.length;s<a;s++){let o=t[s],f=n&&n[s];if(o instanceof Node)e.push(o);else if(!(o==null||o===!0||o===!1))if(Array.isArray(o))i=he(e,o,f)||i;else if(typeof o=="function")if(r){for(;typeof o=="function";)o=o();i=he(e,Array.isArray(o)?o:[o],Array.isArray(f)?f:[f])||i}else e.push(o),i=!0;else{let c=String(o);f&&f.nodeType===3&&f.data===c?e.push(f):e.push(document.createTextNode(c))}}return i}function Fe(e,t,n=null){for(let r=0,i=t.length;r<i;r++)e.insertBefore(t[r],n)}function X(e,t,n,r){if(n===void 0)return e.textContent="";let i=r||document.createTextNode("");if(t.length){let s=!1;for(let a=t.length-1;a>=0;a--){let o=t[a];if(i!==o){let f=o.parentNode===e;!s&&!a?f?e.replaceChild(i,o):e.insertBefore(i,n):f&&o.remove()}else s=!0}}else e.insertBefore(i,n);return[i]}var Ze=D('<div class="CatItem"><div class="Wrap"><img alt=""></div><div class="Wrap"><span>Name: </span></div><div class="Wrap"><span>Breed: </span></div><div class="Wrap"><span>Weight kg: </span></div><div class="Wrap"><span>Weight lbs: </span></div><div class="Wrap"><span>Age(years): </span></div><div class="Wrap"><span>Age(months): </span></div></div>',29),et=({cat:e})=>(()=>{let t=Ze.cloneNode(!0),n=t.firstChild,r=n.firstChild,i=n.nextSibling,s=i.firstChild,a=s.firstChild,o=i.nextSibling,f=o.firstChild,c=f.firstChild,u=o.nextSibling,g=u.firstChild,w=g.firstChild,d=u.nextSibling,m=d.firstChild,C=m.firstChild,v=d.nextSibling,T=v.firstChild,F=T.firstChild,h=v.nextSibling,x=h.firstChild,_=x.firstChild;return A(s,()=>e.name,null),A(f,()=>e.breed,null),A(g,()=>e.weightKg,null),A(m,()=>e.weightLbs,null),A(T,()=>e.ageYears,null),A(x,()=>e.ageMonths,null),N(()=>M(r,"src",e.imageUrl)),t})(),Le=et;var tt=D('<div class="Filters"><label for="ageFrom">Age From</label><input id="ageFrom" name="age_from" type="number"><label for="ageTo">Age To</label><input id="ageTo" name="age_to" type="number"><label for="weightFrom">Weight From</label><input id="weightFrom" name="weight_from" type="number"><label for="weightTo">Weight To</label><input id="weightTo" name="weight_to" type="number"><label for="sort">Sort by</label><select><option value="name">Name Asc</option><option value="-name">Name Desc</option><option value="age">Age Asc</option><option value="-age">Age Desc</option><option value="weight">Weight Asc</option><option value="-weight">Weight Desc</option><option value="breed">Breed Asc</option><option value="-breed">Breed Desc</option></select><button>Apply</button></div>',36),nt=D('<div><input type="checkbox"><label></label></div>',5),rt=({filters:e,updateParams:t,requestParams:n})=>{[requestFilters,setRequestFilters]=O({...n,breed:[],sort:"name"});let r=(o,f)=>{if(o.target.checked)setRequestFilters({...requestFilters(),breed:[...new Set([...requestFilters().breed]),f],page:1});else{let c=new Set([...requestFilters().breed]);c.delete(f),setRequestFilters({...requestFilters(),breed:[...c],page:1})}},i=o=>{setRequestFilters({...requestFilters(),[o.target.name]:parseInt(o.target.value)})},s=o=>{setRequestFilters({...requestFilters(),sort:o.target.value})},a=()=>{t(requestFilters())};return(()=>{let o=tt.cloneNode(!0),f=o.firstChild,c=f.nextSibling,u=c.nextSibling,g=u.nextSibling,w=g.nextSibling,d=w.nextSibling,m=d.nextSibling,C=m.nextSibling,v=C.nextSibling,T=v.nextSibling,F=T.nextSibling;return A(o,I(B,{get each(){return e()?.breed},children:h=>(()=>{let x=nt.cloneNode(!0),_=x.firstChild,q=_.nextSibling;return _.addEventListener("change",W=>r(W,h)),M(_,"id",h),_.value=h,M(q,"for",h),A(q,h),x})()}),f),c.addEventListener("change",i),g.addEventListener("change",i),d.addEventListener("change",i),C.addEventListener("change",i),T.addEventListener("change",s),F.$$click=()=>a(),N(h=>{let x=e()?.ageFrom,_=e()?.ageTo,q=e()?.ageFrom,W=e()?.ageTo,U=e()?.weightFrom,G=e()?.weightTo,b=e()?.weightFrom,S=e()?.weightTo;return x!==h._v$&&M(c,"min",h._v$=x),_!==h._v$2&&M(c,"max",h._v$2=_),q!==h._v$3&&M(g,"min",h._v$3=q),W!==h._v$4&&M(g,"max",h._v$4=W),U!==h._v$5&&M(d,"min",h._v$5=U),G!==h._v$6&&M(d,"max",h._v$6=G),b!==h._v$7&&M(C,"min",h._v$7=b),S!==h._v$8&&M(C,"max",h._v$8=S),h},{_v$:void 0,_v$2:void 0,_v$3:void 0,_v$4:void 0,_v$5:void 0,_v$6:void 0,_v$7:void 0,_v$8:void 0}),N(()=>c.value=e()?.ageFrom),N(()=>g.value=e()?.ageTo),N(()=>d.value=e()?.weightFrom),N(()=>C.value=e()?.weightTo),o})()},Oe=rt;re(["click"]);var it=D("<div></div>",2),st=D("<button></button>",2),ot=({pagy:e,updateParams:t})=>{let n=r=>{t({page:r})};return(()=>{let r=it.cloneNode(!0);return A(r,I(B,{get each(){return[...Array(e().last).keys()]},children:i=>(()=>{let s=st.cloneNode(!0);return s.$$click=()=>n(i+1),A(s,i+1),s})()})),r})()},Ne=ot;re(["click"]);var lt=D('<div class="CatListWrap"><div><div class="CatList"></div></div></div>',6),at=D("<div>No results</div>",2),ut=({serviceType:e})=>{let[t,n]=O(1),[r,i]=O({}),[s,a]=O({page:t(),breed:[]}),o=(d,m)=>{let C=Object.keys(d).map(v=>{let T=d[v];return d.constructor===Array?v=`${m}[]`:d.constructor===Object&&(v=m?`${m}[${v}]`:v),typeof T=="object"?o(T,v):`${v}=${encodeURIComponent(T)}`});return[].concat.apply([],C).join("&")},f=async()=>{let d=await fetch(`http://localhost:3000/business_logic/${e}/cats?`+o(s())).then(m=>m.json());return i(d.pagy),n(d.pagy.page),d.data},c=async()=>(await fetch(`http://localhost:3000/business_logic/${e}/cats/filters`).then(m=>m.json())).filters,u=d=>{a({...s(),...d})},[g]=ae(c),[w]=ae(s,f);return(()=>{let d=lt.cloneNode(!0),m=d.firstChild,C=m.firstChild;return A(d,I(Oe,{filters:g,updateParams:u,requestParams:s}),m),A(C,I(B,{get each(){return w()},get fallback(){return at.cloneNode(!0)},children:v=>I(Le,{cat:v})})),A(m,I(Ne,{pagy:r,updateParams:u}),null),d})()},Me=ut;Pe(()=>I(Me,{serviceType:"poro"}),document.getElementById("app"));})();