"use strict";

const BUNDLE_WEBPACK_SETTING = (
	{
		"entry": (
			[
				`${ process.env.MODULE_ROOT_DIRECTORY_PATH }/${ process.env.MODULE_NAMESPACE_VALUE }.module.js`
			]
		),

		"mode": (
			"production"
		),

		"target": (
			`${ process.env.MODULE_BUILD_TARGET_LIST }`
			.split( /\s*\,\s*/g )
		),

		"output": (
			{
				"filename": (
					`${ process.env.MODULE_NAMESPACE_VALUE }.bundle.js`
				),

				"path": (
					`${ process.env.MODULE_ROOT_DIRECTORY_PATH }/.build`
				),

				"library": (
					{
						"name": (
							`${ process.env.MODULE_NAMESPACE_VARIABLE }`
						),

						"type": (
							"umd"
						),

						"umdNamedDefine": (
							true
						),
					}
				),

				"globalObject": (
					"this"
				),
			}
		),

		"optimization": (
			{
				"minimize": false,
			}
		),
	}
);

(
		module
		.exports
	=	(
			BUNDLE_WEBPACK_SETTING
		)
);
