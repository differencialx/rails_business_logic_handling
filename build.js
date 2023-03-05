const { build } = require("esbuild");
const { solidPlugin } = require("esbuild-plugin-solid");

build({
  entryPoints: ["app/javascript/application.jsx"],
  bundle: true,
  outfile: "app/assets/build/application.js",
  minify: true,
  publicPath: "assets",
  loader: {
    ".svg": "dataurl",
  },
  logLevel: "info",
  plugins: [solidPlugin()],
}).catch(() => process.exit(1));
