const { solidPlugin } = require("esbuild-plugin-solid");
const glob = require("glob");

let jsPromise = require("esbuild").context({
  entryPoints: ["app/javascript/application.jsx"],
  bundle: true,
  outfile: "app/assets/build/application.js",
  minify: false,
  publicPath: "assets",
  loader: {
    ".svg": "dataurl",
  },
  logLevel: "info",
  plugins: [solidPlugin()],
});


jsPromise.then(
  (ctx) => {
    ctx.watch()
  }
).catch(() => process.exit(1))

// glob('./app/javascript/**/!(*.module).css').then(
//   (data) => {
//     let cssPromise = require("esbuild").context({
//       entryPoints: data,
//       bundle: true,
//       outdir: "app/assets/stylesheets/application.css",
//       minify: false,
//       publicPath: "assets",
//       loader: {
//         ".svg": "dataurl",
//       },
//       logLevel: "info"
//     });


//     cssPromise.then(
//       (ctx) => {
//         ctx.watch()
//       }
//     ).catch(() => process.exit(1))
//   }
// )
