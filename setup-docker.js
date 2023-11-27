(function webpackUniversalModuleDefinition(root,factory){if(typeof exports==="object"&&typeof module==="object")module.exports=factory();else if(typeof define==="function"&&define.amd)define("setupDocker",[],factory);else if(typeof exports==="object")exports["setupDocker"]=factory();else root["setupDocker"]=factory()})(this,(()=>(()=>{"use strict";var __webpack_modules__={119:(module,__unused_webpack_exports,__webpack_require__)=>{
/*;!
	@license:module:
		MIT License

		Copyright (c) 2023-present Richeve S. Bebedor <richeve.bebedor@gmail.com>

		@license:copyright:
			Richeve S. Bebedor

			<@license:year-range:2023-present;>

			<@license:contact-detail:richeve.bebedor@gmail.com;>
		@license:copyright;

		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:

		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.

		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
	@license:module;
*/
const setupDocker=async function setupDocker(option){const childProcess=__webpack_require__(81);const fs=__webpack_require__(147);const path=__webpack_require__(17);const util=__webpack_require__(837);const fsAsync=fs.promises;const MODULE_ROOT_DIRECTORY_PATH=process.env.MODULE_ROOT_DIRECTORY_PATH||__dirname;const MODULE_NAMESPACE_VALUE=process.env.MODULE_NAMESPACE_VALUE||JSON.parse(await async function(){try{return await fsAsync.readFile(path.resolve(MODULE_ROOT_DIRECTORY_PATH,"package.json"))}catch(error){console.error(["#cannot-run-setup-docker;","cannot run setup docker;","cannot read package file;","@module-root-directory-path:",MODULE_ROOT_DIRECTORY_PATH,"@option-data:",option,"@error-data:",error]);return}}())?.alias;const SETUP_DOCKER_SCRIPT_PATH=path.resolve(MODULE_ROOT_DIRECTORY_PATH,`${MODULE_NAMESPACE_VALUE}.sh`);const resetStatus=option.resetStatus||void 0;const removeStatus=option.removeStatus||void 0;const SETUP_COMMAND=["source",SETUP_DOCKER_SCRIPT_PATH,typeof resetStatus=="boolean"?`--resetStatus ${resetStatus}`:void 0,typeof removeStatus=="boolean"?`--removeStatus ${removeStatus}`:void 0].filter(Boolean).join(" ");try{childProcess.spawn(`${SETUP_COMMAND}`,{shell:"/bin/bash",stdio:"inherit"})}catch(error){console.error(["#cannot-run-setup-docker;","cannot run setup docker;","@option-data:",option,"@error-data:",error])}};module.exports=setupDocker},81:module=>{module.exports=require("child_process")},147:module=>{module.exports=require("fs")},17:module=>{module.exports=require("path")},837:module=>{module.exports=require("util")}};var __webpack_module_cache__={};function __webpack_require__(moduleId){var cachedModule=__webpack_module_cache__[moduleId];if(cachedModule!==void 0)return cachedModule.exports;var module=__webpack_module_cache__[moduleId]={exports:{}};__webpack_modules__[moduleId](module,module.exports,__webpack_require__);return module.exports}var __webpack_exports__=__webpack_require__(119);return __webpack_exports__})()));