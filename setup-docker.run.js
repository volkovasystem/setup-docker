#! /usr/bin/env node

(
	async	function( ){
				const fs = require( "fs" );
				const path = require( "path" );

				const parseShellParameter = (
					require( "parse-shell-parameter" )
				);

				const fsAsync = (
					fs
					.promises
				);

				const MODULE_ROOT_DIRECTORY_PATH = (
						(
							process
							.env
							.MODULE_ROOT_DIRECTORY_PATH
						)
					||
						(
							__dirname
						)
				);

				const MODULE_NAMESPACE_VALUE = (
						(
							process
							.env
							.MODULE_NAMESPACE_VALUE
						)
					||
						(
							JSON
							.parse(
								(
									await	(
												async	function( ){
															try{
																return	(
																			await	fsAsync
																					.readFile(
																						(
																							path
																							.resolve(
																								(
																									MODULE_ROOT_DIRECTORY_PATH
																								),

																								(
																									"package.json"
																								)
																							)
																						)
																					)
																		);
															}
															catch( error ){
																console.error(
																	(
																		[
																			"#cannot-run-module;",

																			"cannot run module;",
																			"cannot read package file;",

																			"@module-root-directory-path:",
																			MODULE_ROOT_DIRECTORY_PATH,

																			"@parameter-data:",
																			parameter,

																			"@error-data:",
																			error,
																		]
																	)
																);

																return	(
																			undefined
																		);
															}
														}
											)( )
								)
							)
							?.alias
						)
				);

				const MODULE_PATH = (
					`${ MODULE_ROOT_DIRECTORY_PATH }/${ MODULE_NAMESPACE_VALUE }.js`
				);

				const parameter = (
					parseShellParameter( )
				);

				const option = (
					{
					}
				);

				try{
					(
						await	require( `${ MODULE_PATH }` )(
									(
										option
									)
								)
					);
				}
				catch( error ){
					console.error(
						(
							[
								"#cannot-run-module;",

								"cannot run module;",

								"@parameter-data:",
								parameter,

								"@error-data:",
								error,
							]
						)
					);
				}
			}
)( );
