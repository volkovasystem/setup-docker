#! /usr/bin/env node

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

				const resetStatus = (
						(
								(
										(
											/^true$/i
										)
										.test(
											(
												`${ parameter.reset }`
											)
										)
									===	true
								)
						)
					?	(
							true
						)
					:	(
								(
										(
											/^false/i
										)
										.test(
											(
												`${ parameter.reset }`
											)
										)
									===	true
								)
						)
					?	(
							false
						)
					:	(
								(
										(
											/^true$/i
										)
										.test(
											(
												`${ parameter.resetStatus }`
											)
										)
									===	true
								)
						)
					?	(
							true
						)
					:	(
								(
										(
											/^false/i
										)
										.test(
											(
												`${ parameter.resetStatus }`
											)
										)
									===	true
								)
						)
					?	(
							false
						)
					:	(
							undefined
						)
				);

				const removeStatus = (
						(
								(
										(
											/^true$/i
										)
										.test(
											(
												`${ parameter.remove }`
											)
										)
									===	true
								)
						)
					?	(
							true
						)
					:	(
								(
										(
											/^false/i
										)
										.test(
											(
												`${ parameter.remove }`
											)
										)
									===	true
								)
						)
					?	(
							false
						)
					:	(
								(
										(
											/^true$/i
										)
										.test(
											(
												`${ parameter.removeStatus }`
											)
										)
									===	true
								)
						)
					?	(
							true
						)
					:	(
								(
										(
											/^false/i
										)
										.test(
											(
												`${ parameter.removeStatus }`
											)
										)
									===	true
								)
						)
					?	(
							false
						)
					:	(
							undefined
						)
				);

				const option = (
					{
						"resetStatus": (
							resetStatus
						),

						"removeStatus": (
							removeStatus
						),
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
