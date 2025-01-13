# Changelog

## [7.3.0](https://github.com/super-linter/super-linter/compare/v7.2.1...v7.3.0) (2025-01-13)


### 🚀 Features

* add nbqa linter for jupyter notebooks ([#6240](https://github.com/super-linter/super-linter/issues/6240)) ([469f30e](https://github.com/super-linter/super-linter/commit/469f30eb53776d99cde52e60c0e21694a87124d4))


### ⬆️ Dependency updates

* **npm:** bump next ([#6468](https://github.com/super-linter/super-linter/issues/6468)) ([b5a246e](https://github.com/super-linter/super-linter/commit/b5a246e96b912dcfe71eb19b4aa62e453a02ebea))


### 🧰 Maintenance

* fix broken link to sqlfluff config ([#6475](https://github.com/super-linter/super-linter/issues/6475)) ([ae84419](https://github.com/super-linter/super-linter/commit/ae844193ed3e200e74ca4b0a523b7d61956720cb))
* update arm test api version ([#6485](https://github.com/super-linter/super-linter/issues/6485)) ([a6fdbf7](https://github.com/super-linter/super-linter/commit/a6fdbf7f2acde46ab7a592cfff89a7a6e6a0a41b))

## [7.2.1](https://github.com/super-linter/super-linter/compare/v7.2.0...v7.2.1) (2024-12-12)


### 🐛 Bugfixes

* define command options function before use ([#6375](https://github.com/super-linter/super-linter/issues/6375)) ([6b60f4c](https://github.com/super-linter/super-linter/commit/6b60f4c968c6ef706f82d77c242d2e6d398868ff)), closes [#6372](https://github.com/super-linter/super-linter/issues/6372)
* downgrade npm-groovy-lint to 15.0.0 ([#6373](https://github.com/super-linter/super-linter/issues/6373)) ([ffccf2d](https://github.com/super-linter/super-linter/commit/ffccf2d49dce2b1e051e081cc7ee743bdda723fc))
* ensure setting /github/workdir as Git safe directory works always ([#6242](https://github.com/super-linter/super-linter/issues/6242)) ([ec05515](https://github.com/super-linter/super-linter/commit/ec05515e93ce545506111700d06865e66fed8295))
* make git conflict markers check more precise ([#6379](https://github.com/super-linter/super-linter/issues/6379)) ([d929d04](https://github.com/super-linter/super-linter/commit/d929d049cb8f37aaea41733aee6e456e5c74362a))


### ⬆️ Dependency updates

* **bundler:** bump standard from 1.42.0 to 1.42.1 in /dependencies ([#6383](https://github.com/super-linter/super-linter/issues/6383)) ([6776692](https://github.com/super-linter/super-linter/commit/67766920118161891152d9d62eab96f3591a860d))
* **docker:** bump the docker group across 1 directory with 4 updates ([#6381](https://github.com/super-linter/super-linter/issues/6381)) ([0fe8b07](https://github.com/super-linter/super-linter/commit/0fe8b0796b19c6a444b674a3bb5c03af34d17bc2))
* **npm:** bump @stoplight/spectral-cli in /dependencies ([#6389](https://github.com/super-linter/super-linter/issues/6389)) ([39b1577](https://github.com/super-linter/super-linter/commit/39b1577f18b72e5383e36aae4d8bb3dba11bd98a))
* **npm:** bump renovate from 39.15.4 to 39.31.3 in /dependencies ([#6397](https://github.com/super-linter/super-linter/issues/6397)) ([70a684d](https://github.com/super-linter/super-linter/commit/70a684deb66fa53eb5dab2eca96205cc66c2f576))
* **npm:** bump renovate from 39.31.3 to 39.58.1 in /dependencies ([#6432](https://github.com/super-linter/super-linter/issues/6432)) ([71cc525](https://github.com/super-linter/super-linter/commit/71cc52518beb7ed70eb232c6462c51bad363a9fe))
* **php:** bump phpstan/phpstan ([#6419](https://github.com/super-linter/super-linter/issues/6419)) ([24a53df](https://github.com/super-linter/super-linter/commit/24a53df7ba9bc8af3e609b4e5598d91458dbf250))
* **php:** bump the composer group across 1 directory with 2 updates ([#6365](https://github.com/super-linter/super-linter/issues/6365)) ([de5f8a4](https://github.com/super-linter/super-linter/commit/de5f8a47e6a34056a23bbafae950b293569f4771))


### 🧰 Maintenance

* disable fail-fast in ci ([#6399](https://github.com/super-linter/super-linter/issues/6399)) ([102ceb6](https://github.com/super-linter/super-linter/commit/102ceb6a8d60feb91e93a674e48700cc0bbc4c1d))
* move npm audit to a dedicate task ([#6297](https://github.com/super-linter/super-linter/issues/6297)) ([b2d0953](https://github.com/super-linter/super-linter/commit/b2d0953bfc5705a3deda9c2340acf6fe14e3e434))
* update npm deps ([#6401](https://github.com/super-linter/super-linter/issues/6401)) ([7b18a58](https://github.com/super-linter/super-linter/commit/7b18a58c9429b53d6f376f8150daf491e9f21b0c)), closes [#6400](https://github.com/super-linter/super-linter/issues/6400)

## [7.2.0](https://github.com/super-linter/super-linter/compare/v7.1.0...v7.2.0) (2024-11-17)


### 🚀 Features

* allow passing custom options to rust clippy ([#6094](https://github.com/super-linter/super-linter/issues/6094)) ([05d4d4e](https://github.com/super-linter/super-linter/commit/05d4d4e128d14b9c442efdd6617237b0e2ded1c1)), closes [#4001](https://github.com/super-linter/super-linter/issues/4001)
* implement a linter to check git conflicts ([#6113](https://github.com/super-linter/super-linter/issues/6113)) ([e0d8b4f](https://github.com/super-linter/super-linter/commit/e0d8b4fb2f36c890b71c5e14fd46715098c3c6f1))
* lint commit messages with commitlint ([#6118](https://github.com/super-linter/super-linter/issues/6118)) ([5d6e3fc](https://github.com/super-linter/super-linter/commit/5d6e3fcecc2b2906eedc2d15495fd6027bf51a9e))
* optionally remove color codes from output ([#6095](https://github.com/super-linter/super-linter/issues/6095)) ([94920ff](https://github.com/super-linter/super-linter/commit/94920ffcc743ebba42205db26cc4bad16f309498)), closes [#5540](https://github.com/super-linter/super-linter/issues/5540)


### 🐛 Bugfixes

* correctly load custom linter commands ([#6085](https://github.com/super-linter/super-linter/issues/6085)) ([ad0ff68](https://github.com/super-linter/super-linter/commit/ad0ff68c526c79ca1fd61d0225db7662571b8037)), closes [#6084](https://github.com/super-linter/super-linter/issues/6084)


### ⬆️ Dependency updates

* **bundler:** bump standard from 1.40.0 to 1.40.1 in /dependencies ([#6239](https://github.com/super-linter/super-linter/issues/6239)) ([75fb343](https://github.com/super-linter/super-linter/commit/75fb3434dd8338fac1b5616db1f5a564498370ad))
* **bundler:** bump standard from 1.41.0 to 1.41.1 in /dependencies ([#6291](https://github.com/super-linter/super-linter/issues/6291)) ([54782ec](https://github.com/super-linter/super-linter/commit/54782eccc3a321d55598c840167146057f4d13e5))
* **bundler:** bump the rubocop group across 1 directory with 3 updates ([#6348](https://github.com/super-linter/super-linter/issues/6348)) ([6e23e6e](https://github.com/super-linter/super-linter/commit/6e23e6e95389e4a4c98921307ef7a87d86203023))
* **bundler:** bump the rubocop group in /dependencies with 6 updates ([#6252](https://github.com/super-linter/super-linter/issues/6252)) ([a8920a4](https://github.com/super-linter/super-linter/commit/a8920a4c21bc416dcd1d96b70a5f76d7993c69e2))
* **docker:** bump composer/composer from 2.7.6 to 2.8.1 ([#6237](https://github.com/super-linter/super-linter/issues/6237)) ([95b56f1](https://github.com/super-linter/super-linter/commit/95b56f1a2700dfcadc3b5ebda9b7647da95f57ea))
* **docker:** bump golang from 1.23.0-alpine to 1.23.2-alpine ([#6236](https://github.com/super-linter/super-linter/issues/6236)) ([2a42244](https://github.com/super-linter/super-linter/commit/2a42244b37895c51a495f1248397bb69bea918c7))
* **docker:** bump python from 3.12.5-alpine3.20 to 3.12.7-alpine3.20 ([#6235](https://github.com/super-linter/super-linter/issues/6235)) ([c97987c](https://github.com/super-linter/super-linter/commit/c97987ce2af88ca69ee2aa614e198878c23438ff))
* **docker:** bump the docker group across 1 directory with 15 updates ([#6356](https://github.com/super-linter/super-linter/issues/6356)) ([ddabcba](https://github.com/super-linter/super-linter/commit/ddabcba0013165686703808e1b16b6d8747325af))
* **java:** bump the java-gradle group across 2 directories with 2 updates ([#6248](https://github.com/super-linter/super-linter/issues/6248)) ([fd28996](https://github.com/super-linter/super-linter/commit/fd2899662d0a9f8f1dddd571291fc11cb6dac522))
* **java:** bump the java-gradle group across 2 directories with 2 updates ([#6335](https://github.com/super-linter/super-linter/issues/6335)) ([d4402a4](https://github.com/super-linter/super-linter/commit/d4402a4727d63bb6da5ccdab177bda7186dafbbc))
* **npm:** bump @babel/eslint-parser in /dependencies ([#6261](https://github.com/super-linter/super-linter/issues/6261)) ([0891581](https://github.com/super-linter/super-linter/commit/08915817797e117d23ba88c3bd1be99a5254b031))
* **npm:** bump @babel/eslint-parser in /dependencies ([#6307](https://github.com/super-linter/super-linter/issues/6307)) ([538bda9](https://github.com/super-linter/super-linter/commit/538bda9750c98fe25cc69ce2b63fd4f6bd9327b0))
* **npm:** bump @react-native/eslint-config ([#6355](https://github.com/super-linter/super-linter/issues/6355)) ([4013f55](https://github.com/super-linter/super-linter/commit/4013f55081a5c85a7128318b612190113b919f38))
* **npm:** bump @stoplight/spectral-cli in /dependencies ([#6181](https://github.com/super-linter/super-linter/issues/6181)) ([468901b](https://github.com/super-linter/super-linter/commit/468901bc7f7f9e7382b22b11ffd07de41869d703))
* **npm:** bump @stoplight/spectral-cli in /dependencies ([#6337](https://github.com/super-linter/super-linter/issues/6337)) ([918f185](https://github.com/super-linter/super-linter/commit/918f185c8e70ebc6260790da6a3862757e760387))
* **npm:** bump @stoplight/spectral-cli in /dependencies ([#6359](https://github.com/super-linter/super-linter/issues/6359)) ([9b3e0cd](https://github.com/super-linter/super-linter/commit/9b3e0cd5f3cee32b6d11a9e68e4c6e4dfee3d786))
* **npm:** bump asl-validator from 3.8.3 to 3.8.4 in /dependencies ([#6312](https://github.com/super-linter/super-linter/issues/6312)) ([e8c508a](https://github.com/super-linter/super-linter/commit/e8c508a3b95acda635948f0a1a078f2fe89a9905))
* **npm:** bump asl-validator from 3.8.4 to 3.9.0 in /dependencies ([#6357](https://github.com/super-linter/super-linter/issues/6357)) ([f955866](https://github.com/super-linter/super-linter/commit/f95586699f5ef40fe3c167dcd3e3d035ac6c425e))
* **npm:** bump eslint from 8.57.0 to 8.57.1 in /dependencies ([#6177](https://github.com/super-linter/super-linter/issues/6177)) ([86df3f8](https://github.com/super-linter/super-linter/commit/86df3f81d2309e5cdcbd979deff9403f56c38291))
* **npm:** bump markdownlint-cli from 0.41.0 to 0.42.0 in /dependencies ([#6199](https://github.com/super-linter/super-linter/issues/6199)) ([1f9b00c](https://github.com/super-linter/super-linter/commit/1f9b00ce5a3b3ca19240d7a60e87cc8b2741626f))
* **npm:** bump next ([#6256](https://github.com/super-linter/super-linter/issues/6256)) ([6994834](https://github.com/super-linter/super-linter/commit/699483443096c24e82b7244bcc8cbe214b268f29))
* **npm:** bump next ([#6329](https://github.com/super-linter/super-linter/issues/6329)) ([9b2933b](https://github.com/super-linter/super-linter/commit/9b2933b74cb26ee0ada336629f9d5f16bd8474f6))
* **npm:** bump next from 14.2.6 to 14.2.11 in /dependencies ([#6157](https://github.com/super-linter/super-linter/issues/6157)) ([b526eff](https://github.com/super-linter/super-linter/commit/b526effb8b749bc8290f1c5ec05fdc75a1ba110b))
* **npm:** bump npm-groovy-lint from 14.6.0 to 15.0.2 in /dependencies ([#6266](https://github.com/super-linter/super-linter/issues/6266)) ([b8dc2a1](https://github.com/super-linter/super-linter/commit/b8dc2a1466f38964184658091f4c687ebcb64ac8))
* **npm:** bump renovate from 38.55.1 to 39.15.4 in /dependencies ([#6358](https://github.com/super-linter/super-linter/issues/6358)) ([3aff158](https://github.com/super-linter/super-linter/commit/3aff1585265f8327e15b9f67d31e4a86da26f958))
* **npm:** bump standard from 17.1.0 to 17.1.2 in /dependencies ([#6265](https://github.com/super-linter/super-linter/issues/6265)) ([22f5beb](https://github.com/super-linter/super-linter/commit/22f5beb605025ac85b67eca1bfc8444f10d879ee))
* **npm:** bump textlint ([#6305](https://github.com/super-linter/super-linter/issues/6305)) ([e55903c](https://github.com/super-linter/super-linter/commit/e55903c2aa70f5d4b95af8dd2d1e16d1cf3eeeef))
* **npm:** bump the eslint-plugins-configs group across 1 directory with 5 updates ([#6255](https://github.com/super-linter/super-linter/issues/6255)) ([5e252d4](https://github.com/super-linter/super-linter/commit/5e252d43ffa66a2cdebb586ebb5277199c990b7a))
* **npm:** bump the react group across 1 directory with 4 updates ([#6257](https://github.com/super-linter/super-linter/issues/6257)) ([7b76efb](https://github.com/super-linter/super-linter/commit/7b76efbd69ef471b83d5273d4b5d8b3cbd8e5e3f))
* **npm:** bump the react group across 1 directory with 4 updates ([#6332](https://github.com/super-linter/super-linter/issues/6332)) ([b9520be](https://github.com/super-linter/super-linter/commit/b9520bea7ab85daae0eb5c2407c5c0972ac09b0a))
* **npm:** bump the stylelint group across 1 directory with 7 updates ([#6340](https://github.com/super-linter/super-linter/issues/6340)) ([f9e2182](https://github.com/super-linter/super-linter/commit/f9e2182dc13159432f84a91210667289eb79cd1f))
* **npm:** bump the textlint group across 1 directory with 2 updates ([#6259](https://github.com/super-linter/super-linter/issues/6259)) ([2078ebb](https://github.com/super-linter/super-linter/commit/2078ebbcae2a1a733a3fd998bc371f6d2f88b8a2))
* **php:** bump the composer group across 1 directory with 2 updates ([#6249](https://github.com/super-linter/super-linter/issues/6249)) ([b23c022](https://github.com/super-linter/super-linter/commit/b23c02219c4a7ac4498fdbb1fced0d1435bd853c))
* **php:** bump the composer group across 1 directory with 2 updates ([#6344](https://github.com/super-linter/super-linter/issues/6344)) ([8638675](https://github.com/super-linter/super-linter/commit/8638675681e7d24125f71d09bbd20e296a75883c))
* **python:** bump the pip group across 1 directory with 11 updates ([#6350](https://github.com/super-linter/super-linter/issues/6350)) ([1f55d98](https://github.com/super-linter/super-linter/commit/1f55d98b0b1f611bedf57dd26c8476d92391aba3))


### 🧰 Maintenance

* add .ds_store to .gitignore ([#6241](https://github.com/super-linter/super-linter/issues/6241)) ([2bdad66](https://github.com/super-linter/super-linter/commit/2bdad665d3458affddba71a1eac3f21d3f06dd85))
* add mypy to the python group ([#6275](https://github.com/super-linter/super-linter/issues/6275)) ([e69f036](https://github.com/super-linter/super-linter/commit/e69f0364d2fd33c3ea08a4ca973762de2a4e655b))
* configure terraform formatting ([#6092](https://github.com/super-linter/super-linter/issues/6092)) ([dd33b47](https://github.com/super-linter/super-linter/commit/dd33b476f887b19d84d51613d3cec227d5d9d963))
* **dev-docker:** bump node in /dev-dependencies ([#6173](https://github.com/super-linter/super-linter/issues/6173)) ([5367999](https://github.com/super-linter/super-linter/commit/5367999a48fbfd7f917098037c96afda44e841ed))
* **dev-docker:** bump node in /dev-dependencies ([#6300](https://github.com/super-linter/super-linter/issues/6300)) ([ae65f71](https://github.com/super-linter/super-linter/commit/ae65f71b345f20883d58745d9715947d8893ff3c))
* devcontainer, docs, prettier config ([#6119](https://github.com/super-linter/super-linter/issues/6119)) ([170cabf](https://github.com/super-linter/super-linter/commit/170cabf92b9ee74a38a2c035cdd48e63d8d42153))
* explain how to configure the path ([#6244](https://github.com/super-linter/super-linter/issues/6244)) ([0208181](https://github.com/super-linter/super-linter/commit/02081814d883fc3401b8d3bdd67ec66ea91ad7f0))
* **github-actions:** bump actions/upload-artifact ([#6251](https://github.com/super-linter/super-linter/issues/6251)) ([ec9d08a](https://github.com/super-linter/super-linter/commit/ec9d08a2334522236d1a2b8566b51530364b78ad))
* **github-actions:** bump actions/upload-artifact from 4.3.6 to 4.4.0 ([#6097](https://github.com/super-linter/super-linter/issues/6097)) ([00b52f3](https://github.com/super-linter/super-linter/commit/00b52f36b6e86ab2277b50526b088bc294e25e54))
* group dependency updates prs ([#6247](https://github.com/super-linter/super-linter/issues/6247)) ([fed55ef](https://github.com/super-linter/super-linter/commit/fed55ef448dfd4e8002af9367092c4f1b7a55f37))
* improve ignore/exclude examples ([#6088](https://github.com/super-linter/super-linter/issues/6088)) ([c9116aa](https://github.com/super-linter/super-linter/commit/c9116aac88ffa6f475029ec2c9b2a30c365a8ce7))
* manage php dependencies ([#6139](https://github.com/super-linter/super-linter/issues/6139)) ([72a4884](https://github.com/super-linter/super-linter/commit/72a4884f7a37b7409b5ef2c7ab29fb552636bb74))
* move base image to a dedicated group ([#6351](https://github.com/super-linter/super-linter/issues/6351)) ([99b4bf6](https://github.com/super-linter/super-linter/commit/99b4bf6e025eedd387533097c25d43158c533827))
* prepare tests for updates ([#6279](https://github.com/super-linter/super-linter/issues/6279)) ([6c2f03f](https://github.com/super-linter/super-linter/commit/6c2f03ffb423a9c1069f0b42727b119d91f314ec))
* shorten linter versions ([#6176](https://github.com/super-linter/super-linter/issues/6176)) ([fc34cb5](https://github.com/super-linter/super-linter/commit/fc34cb53d9e6a866f9fbeec5c6abd638c3ac46da))
* simplified awk usage for version extraction ([#5893](https://github.com/super-linter/super-linter/issues/5893)) ([dd646d7](https://github.com/super-linter/super-linter/commit/dd646d7b7feddf1e7660f8cf080a2c924ef657db))
* update link to jscpd documentation ([#6117](https://github.com/super-linter/super-linter/issues/6117)) ([058b923](https://github.com/super-linter/super-linter/commit/058b9239d47af5565e7c80f55ec097259ad00673))
* update rollup ([#6203](https://github.com/super-linter/super-linter/issues/6203)) ([c4fe4da](https://github.com/super-linter/super-linter/commit/c4fe4da1f3bda7fd0f28bf92dd357fb9feeef5bf)), closes [#6197](https://github.com/super-linter/super-linter/issues/6197)

## [7.1.0](https://github.com/super-linter/super-linter/compare/v7.0.0...v7.1.0) (2024-08-27)


### 🚀 Features

* add pyink as a Python formatter ([#6083](https://github.com/super-linter/super-linter/issues/6083)) ([5b13ace](https://github.com/super-linter/super-linter/commit/5b13acee46a0eadcd57601d14c7767701faf08db))
* format JSONC and JSON5 with prettier ([#6041](https://github.com/super-linter/super-linter/issues/6041)) ([9f193cc](https://github.com/super-linter/super-linter/commit/9f193cc3c0a4fc246b983c376da0aa3cf0919e8d))
* lint and format dotnet solutions ([#6039](https://github.com/super-linter/super-linter/issues/6039)) ([8ceae0f](https://github.com/super-linter/super-linter/commit/8ceae0f304b5267f2b5d4a3a4326a6d5f3939e3f)), closes [#736](https://github.com/super-linter/super-linter/issues/736)


### ⬆️ Dependency updates

* **bundler:** bump rubocop-rails from 2.25.1 to 2.26.0 in /dependencies ([#6075](https://github.com/super-linter/super-linter/issues/6075)) ([e54ad63](https://github.com/super-linter/super-linter/commit/e54ad635a658df61f599860ee9072846a2d066af))
* **docker:** bump alpine/helm from 3.15.3 to 3.15.4 ([#6053](https://github.com/super-linter/super-linter/issues/6053)) ([1b48fe5](https://github.com/super-linter/super-linter/commit/1b48fe5551b9acbd474304ff191e627788b514e9))
* **docker:** bump alpine/terragrunt from 1.9.4 to 1.9.5 ([#6076](https://github.com/super-linter/super-linter/issues/6076)) ([1d0a32e](https://github.com/super-linter/super-linter/commit/1d0a32ee9191be86d0687ae59cea16f2f8ebfc6d))
* **docker:** bump dart from 3.5.0-sdk to 3.5.1-sdk ([#6077](https://github.com/super-linter/super-linter/issues/6077)) ([accbada](https://github.com/super-linter/super-linter/commit/accbadac0971b76bd09509a1dba419f75954065a))
* **docker:** bump dotnet/sdk ([#6055](https://github.com/super-linter/super-linter/issues/6055)) ([4d4214c](https://github.com/super-linter/super-linter/commit/4d4214ccf7ab13de4ad1b63e2370c36ce3988a55))
* **docker:** bump golang from 1.22.6-alpine to 1.23.0-alpine ([#6035](https://github.com/super-linter/super-linter/issues/6035)) ([0ddf7d3](https://github.com/super-linter/super-linter/commit/0ddf7d39d996c2a1b30043a26410e700672d23fd))
* **docker:** bump golangci/golangci-lint from v1.59.1 to v1.60.1 ([#6030](https://github.com/super-linter/super-linter/issues/6030)) ([7e18323](https://github.com/super-linter/super-linter/commit/7e1832349f699d98006c86a885311539817501eb))
* **docker:** bump golangci/golangci-lint from v1.60.1 to v1.60.3 ([#6078](https://github.com/super-linter/super-linter/issues/6078)) ([544c685](https://github.com/super-linter/super-linter/commit/544c6856595387f67be7974780cdc44179b71df7))
* **docker:** bump goreleaser/goreleaser from v2.1.0 to v2.2.0 ([#6031](https://github.com/super-linter/super-linter/issues/6031)) ([29a2973](https://github.com/super-linter/super-linter/commit/29a297388c9869093051d396869725fc2ec2c874))
* **docker:** bump hashicorp/terraform from 1.9.4 to 1.9.5 ([#6079](https://github.com/super-linter/super-linter/issues/6079)) ([f788b4d](https://github.com/super-linter/super-linter/commit/f788b4d833af0ff74e479865aa8a9413939d8917))
* **docker:** bump mvdan/shfmt from v3.8.0 to v3.9.0 ([#6052](https://github.com/super-linter/super-linter/issues/6052)) ([74e31d7](https://github.com/super-linter/super-linter/commit/74e31d7807345850be23ff05f5670749ab0f2b5a))
* **docker:** bump tenable/terrascan from 1.18.11 to 1.19.2 ([#6054](https://github.com/super-linter/super-linter/issues/6054)) ([1974944](https://github.com/super-linter/super-linter/commit/1974944ac3fd86e3a783df6de16927f8bb85f5a6))
* **docker:** bump terraform-linters/tflint from v0.52.0 to v0.53.0 ([#6056](https://github.com/super-linter/super-linter/issues/6056)) ([1a05fca](https://github.com/super-linter/super-linter/commit/1a05fcab77d31c0f609d4e2a3b53aa1c400aa977))
* **java:** bump com.puppycrawl.tools:checkstyle ([#6069](https://github.com/super-linter/super-linter/issues/6069)) ([b9ae288](https://github.com/super-linter/super-linter/commit/b9ae2888b7062e034d9952a88e48e6854a5393e9))
* **npm:** bump @react-native/eslint-config in /dependencies ([#6070](https://github.com/super-linter/super-linter/issues/6070)) ([74111d2](https://github.com/super-linter/super-linter/commit/74111d2761a39f306c55f0e8536c38c26be6cbbe))
* **npm:** bump asl-validator from 3.8.2 to 3.8.3 in /dependencies ([#6073](https://github.com/super-linter/super-linter/issues/6073)) ([149cc20](https://github.com/super-linter/super-linter/commit/149cc2099cba314f62066ea27aa2923a98ed4b3a))
* **npm:** bump next from 14.2.5 to 14.2.6 in /dependencies ([#6072](https://github.com/super-linter/super-linter/issues/6072)) ([1cd74eb](https://github.com/super-linter/super-linter/commit/1cd74eb0b1ffda8551a690e227a80472a66a5705))
* **npm:** bump react-router-dom from 6.26.0 to 6.26.1 in /dependencies ([#6045](https://github.com/super-linter/super-linter/issues/6045)) ([acd4264](https://github.com/super-linter/super-linter/commit/acd426492289e6246e1fac9b4581bc03e86ef1a3))
* **npm:** bump renovate from 38.27.0 to 38.55.1 in /dependencies ([#6082](https://github.com/super-linter/super-linter/issues/6082)) ([202d47f](https://github.com/super-linter/super-linter/commit/202d47fa8ca12037ba96aeece7eb928a5baefac9))
* **npm:** bump textlint from 14.0.5 to 14.2.0 in /dependencies ([#6047](https://github.com/super-linter/super-linter/issues/6047)) ([012548d](https://github.com/super-linter/super-linter/commit/012548dfe5a1225257248f887f767b3ef4067d6f))
* **python:** bump cfn-lint from 1.9.7 to 1.10.3 in /dependencies/python ([#6048](https://github.com/super-linter/super-linter/issues/6048)) ([a03c956](https://github.com/super-linter/super-linter/commit/a03c956aef18fa617ee0be24990cd8f39f2aa653))
* **python:** bump checkov in /dependencies/python ([#6068](https://github.com/super-linter/super-linter/issues/6068)) ([cf58fd2](https://github.com/super-linter/super-linter/commit/cf58fd2773933f8264dd5960b1f7078d3f2c2ad0))
* **python:** bump mypy from 1.11.1 to 1.11.2 in /dependencies/python ([#6064](https://github.com/super-linter/super-linter/issues/6064)) ([8442590](https://github.com/super-linter/super-linter/commit/8442590ec5bd2a627913a760b204f9a5a59999db))
* **python:** bump ruff from 0.5.7 to 0.6.2 in /dependencies/python ([#6066](https://github.com/super-linter/super-linter/issues/6066)) ([e5d15d0](https://github.com/super-linter/super-linter/commit/e5d15d0ac6d69b4d717ff297d95a77cc4d81842e))
* **python:** bump snakemake in /dependencies/python ([#6067](https://github.com/super-linter/super-linter/issues/6067)) ([57e9914](https://github.com/super-linter/super-linter/commit/57e9914ddab743050c1b12a85ebab8a0db068ce8))
* **python:** bump sqlfluff from 3.1.0 to 3.1.1 in /dependencies/python ([#6065](https://github.com/super-linter/super-linter/issues/6065)) ([d9ac3cb](https://github.com/super-linter/super-linter/commit/d9ac3cbdfb325f00ccd680436d2831fd3be28277))


### 🧰 Maintenance

* add an example about fix mode on gh actions ([#6060](https://github.com/super-linter/super-linter/issues/6060)) ([a5c0cf2](https://github.com/super-linter/super-linter/commit/a5c0cf27db3814f553f231eabc2093294b13e169))
* add details about how jscpd, checkov ignore ([#6059](https://github.com/super-linter/super-linter/issues/6059)) ([d311e54](https://github.com/super-linter/super-linter/commit/d311e54fda2da2e260545981fc8a2330f8c45825)), closes [#6014](https://github.com/super-linter/super-linter/issues/6014)
* configure prettier in the devcontainer ([#6042](https://github.com/super-linter/super-linter/issues/6042)) ([0aa2074](https://github.com/super-linter/super-linter/commit/0aa20740a5c28e959f0452846601e35a91d958c6))
* **dev-docker:** bump node in /dev-dependencies ([#6074](https://github.com/super-linter/super-linter/issues/6074)) ([ae7abe1](https://github.com/super-linter/super-linter/commit/ae7abe15e2d364d48a3385fdd1c4519baa5ea18f))
* format super-linter summaries ([#6063](https://github.com/super-linter/super-linter/issues/6063)) ([11d4aac](https://github.com/super-linter/super-linter/commit/11d4aac68c1143b7ae9d33ec470c5d0eebf73baf))
* new ignore example and set word wrap ([#6080](https://github.com/super-linter/super-linter/issues/6080)) ([6b2ef05](https://github.com/super-linter/super-linter/commit/6b2ef057ca0846ceaaf2ffe8d6fae4ff732d60ec))
* update micromatch dependency ([#6061](https://github.com/super-linter/super-linter/issues/6061)) ([75aedaa](https://github.com/super-linter/super-linter/commit/75aedaafeb1a20fcb672d261cc5b43811f799385))
* update supported linters table ([#6038](https://github.com/super-linter/super-linter/issues/6038)) ([3905209](https://github.com/super-linter/super-linter/commit/39052094ff164e62aac886bf171a6747404679d5))

## [7.0.0](https://github.com/super-linter/super-linter/compare/v6.9.0...v7.0.0) (2024-08-15)


### ⚠ BREAKING CHANGES

* remove undocumented secondary extension case ([#5983](https://github.com/super-linter/super-linter/issues/5983))
* remove sql-lint ([#5991](https://github.com/super-linter/super-linter/issues/5991))

### 🚀 Features

* prettier for additional languages ([#6025](https://github.com/super-linter/super-linter/issues/6025)) ([1d12a31](https://github.com/super-linter/super-linter/commit/1d12a31fce043342d7760004aa7fa7acb1dbd4ab))


### 🐛 Bugfixes

* avoid concurrent edits to the same file ([#6027](https://github.com/super-linter/super-linter/issues/6027)) ([2f0ac20](https://github.com/super-linter/super-linter/commit/2f0ac20566d3037c714fa54f6dd47926d12ae0a1))
* remove intro text from stdout and stderr ([#6020](https://github.com/super-linter/super-linter/issues/6020)) ([3d3274d](https://github.com/super-linter/super-linter/commit/3d3274d18a853d13ef63235a0f83b411e3ddd165))
* remove sql-lint ([#5991](https://github.com/super-linter/super-linter/issues/5991)) ([48d5391](https://github.com/super-linter/super-linter/commit/48d5391b7b27dc1304f87c8fd5ac571f6a4fb526))
* remove undocumented secondary extension case ([#5983](https://github.com/super-linter/super-linter/issues/5983)) ([9131ef7](https://github.com/super-linter/super-linter/commit/9131ef72781dbd9aeb3a07016ae02e6415a88379))


### 🧰 Maintenance

* fix formatting issues ([#6028](https://github.com/super-linter/super-linter/issues/6028)) ([2664cb3](https://github.com/super-linter/super-linter/commit/2664cb3b19839c209e23e9061ab5beeba01c6093))
* remove file_array leftovers ([#6018](https://github.com/super-linter/super-linter/issues/6018)) ([d9bf945](https://github.com/super-linter/super-linter/commit/d9bf945fd2655f151a6768a3324716599059108e))
* run npm audit when installing dependencies ([#5990](https://github.com/super-linter/super-linter/issues/5990)) ([1080af3](https://github.com/super-linter/super-linter/commit/1080af39332e821cfe99c1f5a0a334262efebd8a))

## [6.9.0](https://github.com/super-linter/super-linter/compare/v6.8.0...v6.9.0) (2024-08-14)


### 🚀 Features

* allow customizing gitleaks log level ([#5993](https://github.com/super-linter/super-linter/issues/5993)) ([8dc1475](https://github.com/super-linter/super-linter/commit/8dc1475a3abfd302a74754e0414914525224e30f))
* local fix mode ([#5978](https://github.com/super-linter/super-linter/issues/5978)) ([6fdc091](https://github.com/super-linter/super-linter/commit/6fdc0913612b8dfb8fb12cf4785b84827f243fc8))
* support ignore_gitignored_files with jscpd ([#5958](https://github.com/super-linter/super-linter/issues/5958)) ([0dbe144](https://github.com/super-linter/super-linter/commit/0dbe14433636762a7001dfe1e96d2518d73f774d))


### 🐛 Bugfixes

* add missing fix mode options and test cases ([#5987](https://github.com/super-linter/super-linter/issues/5987)) ([91dc6d7](https://github.com/super-linter/super-linter/commit/91dc6d7234403576113cf4fa8d251b13f1a4108a))
* add missing rspec dependencies ([#5982](https://github.com/super-linter/super-linter/issues/5982)) ([633b8af](https://github.com/super-linter/super-linter/commit/633b8af60dae0ffe1d01a5f56a51183ca7a0855a)), closes [#5980](https://github.com/super-linter/super-linter/issues/5980)
* add RENOVATE_X_IGNORE_RE2 env var to remove warning ([#5986](https://github.com/super-linter/super-linter/issues/5986)) ([ea16cd9](https://github.com/super-linter/super-linter/commit/ea16cd9a1b0667d203fca54e887108e658f8f73f))
* adjust previous commit id on merge commits ([#5950](https://github.com/super-linter/super-linter/issues/5950)) ([928972f](https://github.com/super-linter/super-linter/commit/928972feeb5e4a7075b19074e713d3d40b5e6d4d)), closes [#5941](https://github.com/super-linter/super-linter/issues/5941)
* define private output dir before using it ([#5949](https://github.com/super-linter/super-linter/issues/5949)) ([6d40b40](https://github.com/super-linter/super-linter/commit/6d40b40f8f93864d8406cd4cd150d143db19ec73))
* use cargo clippy instead of cargo-clippy ([#5988](https://github.com/super-linter/super-linter/issues/5988)) ([40410c2](https://github.com/super-linter/super-linter/commit/40410c2d603b5d047cfcc7d8fab9f6d6c277b731))


### ⬆️ Dependency updates

* **bundler:** bump rubocop from 1.62.1 to 1.65.1 in /dependencies ([#6023](https://github.com/super-linter/super-linter/issues/6023)) ([14e7f7c](https://github.com/super-linter/super-linter/commit/14e7f7ca2b54a09afe33df6e5aca5229ac09c18d))
* **docker:** bump alpine/terragrunt from 1.9.2 to 1.9.4 ([#6008](https://github.com/super-linter/super-linter/issues/6008)) ([4131878](https://github.com/super-linter/super-linter/commit/4131878084ff1699b063afa8b93342087753e69a))
* **docker:** bump clj-kondo/clj-kondo ([#5968](https://github.com/super-linter/super-linter/issues/5968)) ([ee9bd34](https://github.com/super-linter/super-linter/commit/ee9bd34f56d2cdbdcd86e29c51817b383364dda1))
* **docker:** bump dart from 3.4.4-sdk to 3.5.0-sdk ([#6006](https://github.com/super-linter/super-linter/issues/6006)) ([af13399](https://github.com/super-linter/super-linter/commit/af13399e678a5905da32fe8dc77f4c7a83fe87ae))
* **docker:** bump golang from 1.22.5-alpine to 1.22.6-alpine ([#6009](https://github.com/super-linter/super-linter/issues/6009)) ([1d0de47](https://github.com/super-linter/super-linter/commit/1d0de4792c6e5bb951e613626889a5bc889acaec))
* **docker:** bump hashicorp/terraform from 1.9.2 to 1.9.4 ([#6007](https://github.com/super-linter/super-linter/issues/6007)) ([a0d551a](https://github.com/super-linter/super-linter/commit/a0d551a95c56953c3e6671441230285a5b10cf96))
* **docker:** bump kustomize/kustomize from v5.4.2 to v5.4.3 ([#5915](https://github.com/super-linter/super-linter/issues/5915)) ([f57c1ab](https://github.com/super-linter/super-linter/commit/f57c1abdaab5aeeeeb84b920a27767c2564ad01a))
* **docker:** bump python from 3.12.4-alpine3.20 to 3.12.5-alpine3.20 ([#6005](https://github.com/super-linter/super-linter/issues/6005)) ([c99307e](https://github.com/super-linter/super-linter/commit/c99307e1253c491bc318dfea3e27fdbef748cbb1))
* **docker:** bump scalameta/scalafmt from v3.8.2 to v3.8.3 ([#5932](https://github.com/super-linter/super-linter/issues/5932)) ([1de649c](https://github.com/super-linter/super-linter/commit/1de649c709c5f7f948c1f140bb28cca0044e338a))
* **docker:** bump yannh/kubeconform from v0.6.6 to v0.6.7 ([#5969](https://github.com/super-linter/super-linter/issues/5969)) ([24a1182](https://github.com/super-linter/super-linter/commit/24a1182e62d236bd9053a58ff145d65d696ec3b5))
* **docker:** bump yoheimuta/protolint from 0.50.3 to 0.50.5 ([#6010](https://github.com/super-linter/super-linter/issues/6010)) ([fa610e0](https://github.com/super-linter/super-linter/commit/fa610e06d3733e2bf4326c4a8724146de9db3d5d))
* **java:** bump com.google.googlejavaformat:google-java-format ([#5961](https://github.com/super-linter/super-linter/issues/5961)) ([b181328](https://github.com/super-linter/super-linter/commit/b181328251ee588ec863d6d214a2a32b49dc65d1))
* **npm:** bump @babel/eslint-parser in /dependencies ([#5938](https://github.com/super-linter/super-linter/issues/5938)) ([8c04245](https://github.com/super-linter/super-linter/commit/8c04245d65e1461cdef6f0fbb10b6f645504f222))
* **npm:** bump @react-native/eslint-config in /dependencies ([#5972](https://github.com/super-linter/super-linter/issues/5972)) ([cb64af2](https://github.com/super-linter/super-linter/commit/cb64af2f56d14c42f8b823c9f0c9a0d59440ddb2))
* **npm:** bump eslint-plugin-jest in /dependencies ([#6000](https://github.com/super-linter/super-linter/issues/6000)) ([9db1d16](https://github.com/super-linter/super-linter/commit/9db1d1695b1f6ca3007f11322ae3cf4e175cfa7d))
* **npm:** bump eslint-plugin-prettier in /dependencies ([#5909](https://github.com/super-linter/super-linter/issues/5909)) ([82a93ec](https://github.com/super-linter/super-linter/commit/82a93ec7c44e21af56ea340fe663a4bd35ab6554))
* **npm:** bump eslint-plugin-react in /dependencies ([#5912](https://github.com/super-linter/super-linter/issues/5912)) ([1e76c51](https://github.com/super-linter/super-linter/commit/1e76c51f6d474a0b25863bf06817824c755f9b78))
* **npm:** bump react-router-dom from 6.25.0 to 6.26.0 in /dependencies ([#5973](https://github.com/super-linter/super-linter/issues/5973)) ([1fa0e57](https://github.com/super-linter/super-linter/commit/1fa0e57975647d9e04dea1395f217317cca29a71))
* **npm:** bump renovate from 37.432.0 to 38.27.0 in /dependencies ([#6022](https://github.com/super-linter/super-linter/issues/6022)) ([ee53c39](https://github.com/super-linter/super-linter/commit/ee53c39ab706ac1d190918a99ed0f5de779cd6f1))
* **npm:** bump textlint from 14.0.4 to 14.0.5 in /dependencies ([#6002](https://github.com/super-linter/super-linter/issues/6002)) ([f106ed2](https://github.com/super-linter/super-linter/commit/f106ed26b34068c4a7909aa9133d539941cd72db))
* **npm:** bump textlint-rule-terminology in /dependencies ([#5976](https://github.com/super-linter/super-linter/issues/5976)) ([bbebf26](https://github.com/super-linter/super-linter/commit/bbebf2678fdfc5876efa53ad16b0ab8227e53ef0))
* **npm:** bump typescript from 5.5.3 to 5.5.4 in /dependencies ([#5934](https://github.com/super-linter/super-linter/issues/5934)) ([23f7aad](https://github.com/super-linter/super-linter/commit/23f7aadc2ec8112c3752dd1fc2bf653be1da52fe))
* **python:** bump black from 24.4.2 to 24.8.0 in /dependencies/python ([#5964](https://github.com/super-linter/super-linter/issues/5964)) ([72858ed](https://github.com/super-linter/super-linter/commit/72858ed8f47aef318d322c0b2fde9fc5ac66042d))
* **python:** bump cfn-lint from 1.6.1 to 1.9.7 in /dependencies/python ([#5996](https://github.com/super-linter/super-linter/issues/5996)) ([d993d82](https://github.com/super-linter/super-linter/commit/d993d82c79e7e6afbf221c97e8c5aea92f0dc4c3))
* **python:** bump checkov in /dependencies/python ([#5997](https://github.com/super-linter/super-linter/issues/5997)) ([bfedf0d](https://github.com/super-linter/super-linter/commit/bfedf0d3345b00d793f4fa8c8783ddb1dbbbba9b))
* **python:** bump flake8 from 7.1.0 to 7.1.1 in /dependencies/python ([#5967](https://github.com/super-linter/super-linter/issues/5967)) ([8b51793](https://github.com/super-linter/super-linter/commit/8b5179360c8e75adc43561a33953e4b84fb6c7eb))
* **python:** bump mypy from 1.10.1 to 1.11.1 in /dependencies/python ([#5965](https://github.com/super-linter/super-linter/issues/5965)) ([b6da527](https://github.com/super-linter/super-linter/commit/b6da527b29fe9aba6f2fa168bb340fbdc5d81b83))
* **python:** bump pylint from 3.2.5 to 3.2.6 in /dependencies/python ([#5920](https://github.com/super-linter/super-linter/issues/5920)) ([04ee4f3](https://github.com/super-linter/super-linter/commit/04ee4f3ae541b7a5d33bfadaed0ba660aade4182))
* **python:** bump ruff from 0.5.2 to 0.5.7 in /dependencies/python ([#5998](https://github.com/super-linter/super-linter/issues/5998)) ([3fdcf5c](https://github.com/super-linter/super-linter/commit/3fdcf5c08525bf8a8d90903db23cd76ae13f5b27))


### 🧰 Maintenance

* add info about standard and prettier ([#5948](https://github.com/super-linter/super-linter/issues/5948)) ([b09ac00](https://github.com/super-linter/super-linter/commit/b09ac00c68aa2da994b9dc09308e13a5808ee2fb))
* add linter commands tests ([#5957](https://github.com/super-linter/super-linter/issues/5957)) ([16dbf17](https://github.com/super-linter/super-linter/commit/16dbf17306476db3158ea632d25d427f8ea49983))
* add tests for linter rules path corner case ([#5981](https://github.com/super-linter/super-linter/issues/5981)) ([10e132a](https://github.com/super-linter/super-linter/commit/10e132a8f7fd50bf70a07bef793c5b50766f4d0b))
* automatically set scalafmt version ([#6024](https://github.com/super-linter/super-linter/issues/6024)) ([38dd638](https://github.com/super-linter/super-linter/commit/38dd638c34d4ab0b453296e625586978db01cbfa))
* **dev-docker:** bump node in /dev-dependencies ([#6011](https://github.com/super-linter/super-linter/issues/6011)) ([97390c9](https://github.com/super-linter/super-linter/commit/97390c90d42207c472832d578d2a8693185e12e5))
* **dev-npm:** bump @commitlint/cli in /dev-dependencies ([#6012](https://github.com/super-linter/super-linter/issues/6012)) ([55970c9](https://github.com/super-linter/super-linter/commit/55970c96812992d1f53ce114e8a7068da9645a68))
* disable dotnet telemetry ([#6016](https://github.com/super-linter/super-linter/issues/6016)) ([4854e77](https://github.com/super-linter/super-linter/commit/4854e774f3382038d2c595bbd0df17eb356d89fa))
* extract language array definition ([#5945](https://github.com/super-linter/super-linter/issues/5945)) ([d959232](https://github.com/super-linter/super-linter/commit/d9592327c6cfa469a0778ed2298f022c68e5cf45))
* fetch the whole repo when setting build meta ([#6017](https://github.com/super-linter/super-linter/issues/6017)) ([1d10435](https://github.com/super-linter/super-linter/commit/1d104357a50d76ad7dff94e3809e98c9b572075a))
* fix build metadata ([#6015](https://github.com/super-linter/super-linter/issues/6015)) ([82094c8](https://github.com/super-linter/super-linter/commit/82094c879beda024f7a29b351fb67a3be54913e0))
* fix output formatting ([#5942](https://github.com/super-linter/super-linter/issues/5942)) ([55a47ff](https://github.com/super-linter/super-linter/commit/55a47ff317173467550f570dbeb819be6526fe2f))
* fix two default values in readme ([#5944](https://github.com/super-linter/super-linter/issues/5944)) ([c5ba687](https://github.com/super-linter/super-linter/commit/c5ba6872c6a3f8f01efa5637080f25549e38936d))
* fix typos in README ([#5959](https://github.com/super-linter/super-linter/issues/5959)) ([1ec0205](https://github.com/super-linter/super-linter/commit/1ec0205b4278f5aad5f82412ba5277ce36f14457))
* **github-actions:** bump actions/upload-artifact from 4.3.4 to 4.3.6 ([#6004](https://github.com/super-linter/super-linter/issues/6004)) ([f67156f](https://github.com/super-linter/super-linter/commit/f67156f2484ff8efdf061c728add403b3869e552))
* **github-actions:** bump docker/login-action from 3.2.0 to 3.3.0 ([#5914](https://github.com/super-linter/super-linter/issues/5914)) ([0d6fd13](https://github.com/super-linter/super-linter/commit/0d6fd13613f86927688b466f77bc901448569e44))
* mount the whole lib dir in the devcontainer ([#5984](https://github.com/super-linter/super-linter/issues/5984)) ([30fc3ae](https://github.com/super-linter/super-linter/commit/30fc3ae1997e7d8828f8d2d8013c433f4cef0dda))
* move rules vars to a dedicated file ([#5946](https://github.com/super-linter/super-linter/issues/5946)) ([14a6ee6](https://github.com/super-linter/super-linter/commit/14a6ee6da668183c5382e24eb93c975020c1899e))
* remove clippy script, run clippy directly ([#5953](https://github.com/super-linter/super-linter/issues/5953)) ([c46346c](https://github.com/super-linter/super-linter/commit/c46346c7743f7ce191073a49d90a1fa7b3d11996))
* remove h1 from the pr template ([#5985](https://github.com/super-linter/super-linter/issues/5985)) ([d0219e3](https://github.com/super-linter/super-linter/commit/d0219e326d637c906e31d853b7fc2f9a98c93dad))
* remove test leftovers before running fix test ([#5995](https://github.com/super-linter/super-linter/issues/5995)) ([0c6e9a5](https://github.com/super-linter/super-linter/commit/0c6e9a5778e1f970c7f2c88dec755b988e74ea20)), closes [#5994](https://github.com/super-linter/super-linter/issues/5994)
* set build_version dynamically ([#6013](https://github.com/super-linter/super-linter/issues/6013)) ([bde3b93](https://github.com/super-linter/super-linter/commit/bde3b9368e78f0cbae6316edd9657b8a5c0f55d3)), closes [#4928](https://github.com/super-linter/super-linter/issues/4928)

## [6.8.0](https://github.com/super-linter/super-linter/compare/v6.7.0...v6.8.0) (2024-07-31)


### 🚀 Features

* allow using both prettier and standardjs ([#5679](https://github.com/super-linter/super-linter/issues/5679)) ([2daf461](https://github.com/super-linter/super-linter/commit/2daf461143778318ccc60ba59f175d385f222e4d))
* customize phpstan config file name ([#5940](https://github.com/super-linter/super-linter/issues/5940)) ([20c4df5](https://github.com/super-linter/super-linter/commit/20c4df58c060cf122dce53b14ec578d48d921fb0))
* enable dotenv-linter for slim images ([#5868](https://github.com/super-linter/super-linter/issues/5868)) ([c770a8d](https://github.com/super-linter/super-linter/commit/c770a8d253f8b8852fd3404b63b807d93cc3691a))
* remove no-eslintrc and simplify eslint conf ([#5809](https://github.com/super-linter/super-linter/issues/5809)) ([5be4926](https://github.com/super-linter/super-linter/commit/5be49266330f237f4a8ab2acccffe93b69cf4b04)), closes [#5688](https://github.com/super-linter/super-linter/issues/5688)
* write github actions step summary ([#5867](https://github.com/super-linter/super-linter/issues/5867)) ([57c8658](https://github.com/super-linter/super-linter/commit/57c86588c388a515ae31f498b4cc4a6337169c11)), closes [#5650](https://github.com/super-linter/super-linter/issues/5650)


### 🐛 Bugfixes

* avoid duplicated content in summary ([#5939](https://github.com/super-linter/super-linter/issues/5939)) ([ef57e13](https://github.com/super-linter/super-linter/commit/ef57e132e136ab9991a0cc1517236e827d27baf9))
* store outputs in the main output directory ([#5899](https://github.com/super-linter/super-linter/issues/5899)) ([78ed3ef](https://github.com/super-linter/super-linter/commit/78ed3ef5fc8fe45290b530f94077281d2ac8e634))
* update pylint to ignore import-errors ([#5927](https://github.com/super-linter/super-linter/issues/5927)) ([eec862d](https://github.com/super-linter/super-linter/commit/eec862d0ea33fe6a836dfd545eef1125e530c794))
* update the list of linters to remove ([#5870](https://github.com/super-linter/super-linter/issues/5870)) ([6bd7659](https://github.com/super-linter/super-linter/commit/6bd76596f3f7df70a323eabb797f028293873424))


### ⬆️ Dependency updates

* **bundler:** bump rubocop-minitest in /dependencies ([#5875](https://github.com/super-linter/super-linter/issues/5875)) ([9751e62](https://github.com/super-linter/super-linter/commit/9751e62beed14780ff12fc073c7aa9eafbd449f7))
* **bundler:** bump rubocop-performance in /dependencies ([#5777](https://github.com/super-linter/super-linter/issues/5777)) ([763dcc4](https://github.com/super-linter/super-linter/commit/763dcc4d456ae0c347801d30b5ec00dbfaa60ef2))
* **bundler:** bump rubocop-rspec from 2.30.0 to 3.0.3 in /dependencies ([#5878](https://github.com/super-linter/super-linter/issues/5878)) ([592d903](https://github.com/super-linter/super-linter/commit/592d903c509a4c70c89cc009e74b63c3273c5e7b))
* **dev-docker:** bump node in /dev-dependencies ([#5872](https://github.com/super-linter/super-linter/issues/5872)) ([587fe0a](https://github.com/super-linter/super-linter/commit/587fe0a8b9318324fbfd86b9cd87b0ac6b24ba42))
* **dev-npm:** bump release-please in /dev-dependencies ([#5754](https://github.com/super-linter/super-linter/issues/5754)) ([6bb3f78](https://github.com/super-linter/super-linter/commit/6bb3f789bb5cacff35492a1245befb2fd13b97f5))
* **docker:** bump alpine/helm from 3.14.4 to 3.15.3 ([#5882](https://github.com/super-linter/super-linter/issues/5882)) ([b5bf9f2](https://github.com/super-linter/super-linter/commit/b5bf9f297d13e9563bd708ae98e2e05b9b44698c))
* **docker:** bump alpine/terragrunt from 1.9.0 to 1.9.2 ([#5883](https://github.com/super-linter/super-linter/issues/5883)) ([95feeac](https://github.com/super-linter/super-linter/commit/95feeacb0ab075e7e183c5f8ea1c515992f66bbf))
* **docker:** bump dart from 3.4.2-sdk to 3.4.4-sdk ([#5764](https://github.com/super-linter/super-linter/issues/5764)) ([b75f1cf](https://github.com/super-linter/super-linter/commit/b75f1cfcefc1b62a81b916bd00d0b8dfa7ad69aa))
* **docker:** bump dotnet/sdk ([#5873](https://github.com/super-linter/super-linter/issues/5873)) ([f068663](https://github.com/super-linter/super-linter/commit/f06866359b4158e04825a03d5852823d47d78b05))
* **docker:** bump golangci/golangci-lint from v1.59.0 to v1.59.1 ([#5748](https://github.com/super-linter/super-linter/issues/5748)) ([81ab76d](https://github.com/super-linter/super-linter/commit/81ab76d00179b8d66e7f909c546cb7bfbde8ae9f))
* **docker:** bump goreleaser/goreleaser from v1.26.2 to v2.1.0 ([#5881](https://github.com/super-linter/super-linter/issues/5881)) ([d84d439](https://github.com/super-linter/super-linter/commit/d84d4393933047f08abf0871aacefa04c63b5f32))
* **docker:** bump hashicorp/terraform from 1.8.4 to 1.9.2 ([#5885](https://github.com/super-linter/super-linter/issues/5885)) ([d384e67](https://github.com/super-linter/super-linter/commit/d384e674c729dfd236ce888d04e4bdd24a85b630))
* **docker:** bump mstruebing/editorconfig-checker from v3.0.1 to v3.0.3 ([#5856](https://github.com/super-linter/super-linter/issues/5856)) ([81196f4](https://github.com/super-linter/super-linter/commit/81196f4267199e63ec82dd0aaff9d1f400b38cac))
* **docker:** bump python from 3.12.3-alpine3.20 to 3.12.4-alpine3.20 ([#5884](https://github.com/super-linter/super-linter/issues/5884)) ([8a044b5](https://github.com/super-linter/super-linter/commit/8a044b58dee1dd7a03fcaf2d7d6b58754f156be2))
* **docker:** bump scalameta/scalafmt from v3.8.1 to v3.8.2 ([#5765](https://github.com/super-linter/super-linter/issues/5765)) ([4931da5](https://github.com/super-linter/super-linter/commit/4931da55da35a8b438354adc03d220f693458f75))
* **docker:** bump terraform-linters/tflint from v0.51.2 to v0.52.0 ([#5858](https://github.com/super-linter/super-linter/issues/5858)) ([ae1dba5](https://github.com/super-linter/super-linter/commit/ae1dba53fdc862da0064f56382dd86cd273862f6))
* **docker:** bump yoheimuta/protolint from 0.50.2 to 0.50.3 ([#5857](https://github.com/super-linter/super-linter/issues/5857)) ([913bd0d](https://github.com/super-linter/super-linter/commit/913bd0dd47d3a42d6f2d3acad8fb59c2f185337b))
* **docker:** bump zricethezav/gitleaks from v8.18.3 to v8.18.4 ([#5768](https://github.com/super-linter/super-linter/issues/5768)) ([33bb4b4](https://github.com/super-linter/super-linter/commit/33bb4b46d473c80a82364c50746ed20d19231f90))
* **github-actions:** bump actions/download-artifact from 4.1.7 to 4.1.8 ([#5861](https://github.com/super-linter/super-linter/issues/5861)) ([ed72e66](https://github.com/super-linter/super-linter/commit/ed72e66416df8df15b492f7df00b8621b556893f))
* **github-actions:** bump actions/upload-artifact from 4.3.3 to 4.3.4 ([#5860](https://github.com/super-linter/super-linter/issues/5860)) ([dd4313c](https://github.com/super-linter/super-linter/commit/dd4313c9b3bee70bfd968923e77430f3f19785aa))
* **github-actions:** bump docker/build-push-action from 5 to 6 ([#5770](https://github.com/super-linter/super-linter/issues/5770)) ([27170b8](https://github.com/super-linter/super-linter/commit/27170b8e9243df7e18e59e7c43163b142568ee22))
* **java:** bump com.pinterest.ktlint:ktlint-cli in /dependencies/ktlint ([#5849](https://github.com/super-linter/super-linter/issues/5849)) ([19c5fce](https://github.com/super-linter/super-linter/commit/19c5fcea2ea6a72741e59a30cb815c5faac524be))
* **npm:** bump @babel/eslint-parser in /dependencies ([#5886](https://github.com/super-linter/super-linter/issues/5886)) ([387a2b5](https://github.com/super-linter/super-linter/commit/387a2b56261451b12b00fc37d2fb79766564044d))
* **npm:** bump @babel/preset-react in /dependencies ([#5740](https://github.com/super-linter/super-linter/issues/5740)) ([4eeb628](https://github.com/super-linter/super-linter/commit/4eeb62862e823fd431fefb0078e5605484934254))
* **npm:** bump @babel/preset-typescript in /dependencies ([#5734](https://github.com/super-linter/super-linter/issues/5734)) ([de4b193](https://github.com/super-linter/super-linter/commit/de4b1930064cb6b5f65625101be33892c50d400f))
* **npm:** bump @react-native/eslint-config in /dependencies ([#5835](https://github.com/super-linter/super-linter/issues/5835)) ([28c228d](https://github.com/super-linter/super-linter/commit/28c228dfc0b8279e28ca5bb72a34e9390eca81b9))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5895](https://github.com/super-linter/super-linter/issues/5895)) ([7f5b018](https://github.com/super-linter/super-linter/commit/7f5b018fb7237ef0d6d1cb1578729065bacb4310))
* **npm:** bump eslint-plugin-jest in /dependencies ([#5738](https://github.com/super-linter/super-linter/issues/5738)) ([1312398](https://github.com/super-linter/super-linter/commit/1312398b9c72138ce76f443dd933a8ff82f75fae))
* **npm:** bump eslint-plugin-jsx-a11y in /dependencies ([#5797](https://github.com/super-linter/super-linter/issues/5797)) ([8972772](https://github.com/super-linter/super-linter/commit/89727727323246be93c3ed88c0b0fe1f07e25468))
* **npm:** bump eslint-plugin-react in /dependencies ([#5890](https://github.com/super-linter/super-linter/issues/5890)) ([fe3e1f8](https://github.com/super-linter/super-linter/commit/fe3e1f83b7c7645640af9202bb7f4d8993f088fc))
* **npm:** bump eslint-plugin-vue from 9.26.0 to 9.27.0 in /dependencies ([#5851](https://github.com/super-linter/super-linter/issues/5851)) ([c2e85a9](https://github.com/super-linter/super-linter/commit/c2e85a9f03ceccfe41107ea1e627c8c222b2154a))
* **npm:** bump jscpd from 4.0.4 to 4.0.5 in /dependencies ([#5852](https://github.com/super-linter/super-linter/issues/5852)) ([042c6b1](https://github.com/super-linter/super-linter/commit/042c6b191708878b5db2b5096eadb1b4a6f4f27d))
* **npm:** bump next from 14.2.3 to 14.2.5 in /dependencies ([#5887](https://github.com/super-linter/super-linter/issues/5887)) ([22b7ba9](https://github.com/super-linter/super-linter/commit/22b7ba91d0d273fdc5369d1ead66ae2cee451df0))
* **npm:** bump prettier from 3.3.2 to 3.3.3 in /dependencies ([#5891](https://github.com/super-linter/super-linter/issues/5891)) ([b601212](https://github.com/super-linter/super-linter/commit/b6012126df99c9a8cdc5878bb9417ca7afee6809))
* **npm:** bump react-router-dom from 6.23.1 to 6.25.0 in /dependencies ([#5897](https://github.com/super-linter/super-linter/issues/5897)) ([ef71e94](https://github.com/super-linter/super-linter/commit/ef71e944ab41a8f04ba143f44d4b8443d2d982b5))
* **npm:** bump renovate from 37.421.5 to 37.432.0 in /dependencies ([#5896](https://github.com/super-linter/super-linter/issues/5896)) ([09a01eb](https://github.com/super-linter/super-linter/commit/09a01ebbe6dbb5e502817bb927191b8986c7c912))
* **npm:** bump textlint-rule-terminology in /dependencies ([#5853](https://github.com/super-linter/super-linter/issues/5853)) ([55b065d](https://github.com/super-linter/super-linter/commit/55b065d3c2d512648c52d4d695761a7d274ae769))
* **npm:** bump typescript from 5.4.5 to 5.5.3 in /dependencies ([#5832](https://github.com/super-linter/super-linter/issues/5832)) ([8605c2b](https://github.com/super-linter/super-linter/commit/8605c2b584b36201ac8d1acf98254c2d70776c75))
* **python:** bump ansible-lint in /dependencies/python ([#5877](https://github.com/super-linter/super-linter/issues/5877)) ([e90ee32](https://github.com/super-linter/super-linter/commit/e90ee328a2f6eb42952eeda45929271fddaf0c77))
* **python:** bump cfn-lint from 1.4.2 to 1.6.1 in /dependencies/python ([#5876](https://github.com/super-linter/super-linter/issues/5876)) ([ebf8cc8](https://github.com/super-linter/super-linter/commit/ebf8cc807a6c756755e790419fefcf9e5353b911))
* **python:** bump checkov in /dependencies/python ([#5879](https://github.com/super-linter/super-linter/issues/5879)) ([47392ad](https://github.com/super-linter/super-linter/commit/47392ad6636919b4b21e6ef2c3e1418cb1e931f3))
* **python:** bump flake8 from 7.0.0 to 7.1.0 in /dependencies/python ([#5780](https://github.com/super-linter/super-linter/issues/5780)) ([f019ee3](https://github.com/super-linter/super-linter/commit/f019ee34d21aa778d4b04217e7f717779ddfa767))
* **python:** bump ruff from 0.5.0 to 0.5.2 in /dependencies/python ([#5880](https://github.com/super-linter/super-linter/issues/5880)) ([3fd69a1](https://github.com/super-linter/super-linter/commit/3fd69a107b05f04135f1c01544c50b940a3b1e99))
* **python:** bump snakemake in /dependencies/python ([#5874](https://github.com/super-linter/super-linter/issues/5874)) ([2b6aa12](https://github.com/super-linter/super-linter/commit/2b6aa1290608468ee3828efdeabbeb467be43b80))
* **python:** bump sqlfluff from 3.0.7 to 3.1.0 in /dependencies/python ([#5847](https://github.com/super-linter/super-linter/issues/5847)) ([31da61e](https://github.com/super-linter/super-linter/commit/31da61e1899ca3c9d26681c265b0928b559f1274))


### 🧰 Maintenance

* add super-linter configuration in the bug template ([#5910](https://github.com/super-linter/super-linter/issues/5910)) ([26ddd8b](https://github.com/super-linter/super-linter/commit/26ddd8b084201554e0351abf421d184864076a56))
* authenticate tflint init ([#5894](https://github.com/super-linter/super-linter/issues/5894)) ([cc20e45](https://github.com/super-linter/super-linter/commit/cc20e4561e549c6f6609900ba68602930c01fb7d))
* bump alpine image to 3.20 and php to 8.3.x ([#5863](https://github.com/super-linter/super-linter/issues/5863)) ([d9d1909](https://github.com/super-linter/super-linter/commit/d9d19095ecf48511e4c21a2e23f0def36187d141))
* enable dev-dependencies docker build checks ([#5871](https://github.com/super-linter/super-linter/issues/5871)) ([12da497](https://github.com/super-linter/super-linter/commit/12da4973c69e6987217089a418199a8227f658d7))
* fix docker build warnings ([#5862](https://github.com/super-linter/super-linter/issues/5862)) ([fc094cc](https://github.com/super-linter/super-linter/commit/fc094cc1a4be6a290c49c633fb857c454a98da47))
* print info about the environment, image size ([#5869](https://github.com/super-linter/super-linter/issues/5869)) ([bcf8ca8](https://github.com/super-linter/super-linter/commit/bcf8ca82ad571bb0a04f028193b3f56486cfbeb4))
* remove duplicated configuration files ([#5928](https://github.com/super-linter/super-linter/issues/5928)) ([70e0239](https://github.com/super-linter/super-linter/commit/70e02391170f6aaff4f0b4e80bf9bc8300940171))
* run docker build checks ([#5864](https://github.com/super-linter/super-linter/issues/5864)) ([ce59f5c](https://github.com/super-linter/super-linter/commit/ce59f5c323a8e5038753582dc265ab172b654834))
* split validation logic in smaller functions ([#5892](https://github.com/super-linter/super-linter/issues/5892)) ([d2d7334](https://github.com/super-linter/super-linter/commit/d2d73347d3e49fb28061a41df471afdcf0a579ba))
* update dependabot config for ci/dev updates ([#5898](https://github.com/super-linter/super-linter/issues/5898)) ([e374e48](https://github.com/super-linter/super-linter/commit/e374e489339410662293e39f4147dc69d098077f))
* update release-please to the new workspace ([#5901](https://github.com/super-linter/super-linter/issues/5901)) ([2ecf945](https://github.com/super-linter/super-linter/commit/2ecf94533920fb6a90ba5f029230cd4cdc69f855))

## [6.7.0](https://github.com/super-linter/super-linter/compare/v6.6.0...v6.7.0) (2024-07-05)


### 🚀 Features

* add the kustomize binary for checkov ([#5763](https://github.com/super-linter/super-linter/issues/5763)) ([d74351f](https://github.com/super-linter/super-linter/commit/d74351fda71d8741d88873e29622baa07e8ad6de))
* checkov scans for helm charts ([#5631](https://github.com/super-linter/super-linter/issues/5631)) ([5b5d2f7](https://github.com/super-linter/super-linter/commit/5b5d2f7ef0c308f904d2e30528e6dddad0a3498a))
* configure github server url ([#5792](https://github.com/super-linter/super-linter/issues/5792)) ([cef1776](https://github.com/super-linter/super-linter/commit/cef17760de240af6d67fc59739c2be585e090037)), closes [#5572](https://github.com/super-linter/super-linter/issues/5572)
* save super-linter output if requested ([#5806](https://github.com/super-linter/super-linter/issues/5806)) ([94bb3f5](https://github.com/super-linter/super-linter/commit/94bb3f5563cd6c031c4eeff052d448bc8a6a0fe9)), closes [#5774](https://github.com/super-linter/super-linter/issues/5774)


### 🐛 Bugfixes

* don't skip processing ansible_directory pwd ([#5790](https://github.com/super-linter/super-linter/issues/5790)) ([c99ec77](https://github.com/super-linter/super-linter/commit/c99ec7784ac7ee89917055456f747c8085f5bf29))


### ⬆️ Dependency updates

* **bundler:** bump rubocop-rails from 2.25.0 to 2.25.1 in /dependencies ([#5823](https://github.com/super-linter/super-linter/issues/5823)) ([6c4bb6d](https://github.com/super-linter/super-linter/commit/6c4bb6d95e6916aa3014fe54d107bcd84a3d329d))
* **docker:** bump alpine/terragrunt from 1.8.4 to 1.9.0 ([#5822](https://github.com/super-linter/super-linter/issues/5822)) ([ea5fe9f](https://github.com/super-linter/super-linter/commit/ea5fe9fbeef4f81c6233ccaac3a90111e0bbd90a))
* **docker:** bump golang from 1.22.3-alpine to 1.22.5-alpine ([#5828](https://github.com/super-linter/super-linter/issues/5828)) ([a138ab3](https://github.com/super-linter/super-linter/commit/a138ab33885c70bda2374eb1bf889337eb484691))
* **docker:** bump kustomize/kustomize from v5.0.1 to v5.4.2 ([#5820](https://github.com/super-linter/super-linter/issues/5820)) ([b3b3bcc](https://github.com/super-linter/super-linter/commit/b3b3bcc53ea00270522845c6016a49ba9caa67d9))
* **docker:** bump terraform-linters/tflint from v0.51.1 to v0.51.2 ([#5821](https://github.com/super-linter/super-linter/issues/5821)) ([56d2bd3](https://github.com/super-linter/super-linter/commit/56d2bd303ab3129084eb5d888dedec9056eba6fc))
* **docker:** bump yoheimuta/protolint from 0.49.7 to 0.50.2 ([#5819](https://github.com/super-linter/super-linter/issues/5819)) ([9733e88](https://github.com/super-linter/super-linter/commit/9733e88b814e2d182edfe2ef08ffdea09f9f7407))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5810](https://github.com/super-linter/super-linter/issues/5810)) ([100de81](https://github.com/super-linter/super-linter/commit/100de813838c4a32b0b89281373b2a5e01161fb0))
* **npm:** bump renovate from 37.387.0 to 37.421.5 in /dependencies ([#5812](https://github.com/super-linter/super-linter/issues/5812)) ([d84e105](https://github.com/super-linter/super-linter/commit/d84e105ccaf23709402888e662dcde1368a1b50d))
* **npm:** bump textlint-rule-terminology in /dependencies ([#5813](https://github.com/super-linter/super-linter/issues/5813)) ([2d9cfec](https://github.com/super-linter/super-linter/commit/2d9cfeccedf9fc63e052f73d5f809d9c44a9bbed))
* **python:** bump cfn-lint from 0.87.4 to 1.4.2 in /dependencies/python ([#5814](https://github.com/super-linter/super-linter/issues/5814)) ([7fe3194](https://github.com/super-linter/super-linter/commit/7fe3194a426193e7fdaf816c4551fd71d9ff3a25))
* **python:** bump checkov in /dependencies/python ([#5815](https://github.com/super-linter/super-linter/issues/5815)) ([9e52a6a](https://github.com/super-linter/super-linter/commit/9e52a6a41e7fbd1c4cda174db462b0149747fb28))
* **python:** bump mypy from 1.10.0 to 1.10.1 in /dependencies/python ([#5817](https://github.com/super-linter/super-linter/issues/5817)) ([9c1a40c](https://github.com/super-linter/super-linter/commit/9c1a40c281429c137dad3352c2b1b8e544dd25f6))
* **python:** bump pylint from 3.2.2 to 3.2.5 in /dependencies/python ([#5816](https://github.com/super-linter/super-linter/issues/5816)) ([0d06369](https://github.com/super-linter/super-linter/commit/0d06369d121f8f4cca60dcc74dcf97cef495a539))
* **python:** bump ruff from 0.4.7 to 0.5.0 in /dependencies/python ([#5818](https://github.com/super-linter/super-linter/issues/5818)) ([86eb9b6](https://github.com/super-linter/super-linter/commit/86eb9b634c96e7ae424b16aaf26cc01b64ce9e0a))


### 🧰 Maintenance

* add missing validate_jsonc var in readme ([#5826](https://github.com/super-linter/super-linter/issues/5826)) ([5b8b99e](https://github.com/super-linter/super-linter/commit/5b8b99e1082f21ddf30e8415df5e23eeb2b08617))
* check for skipped and cancelled matrix jobs ([#5840](https://github.com/super-linter/super-linter/issues/5840)) ([32a200b](https://github.com/super-linter/super-linter/commit/32a200b72a301b4960fa9b067a1a8708ad8ab285))
* fix linting errors ([#5839](https://github.com/super-linter/super-linter/issues/5839)) ([aa390de](https://github.com/super-linter/super-linter/commit/aa390de227c237b64fb6281626c947a287fb9923)), closes [#5838](https://github.com/super-linter/super-linter/issues/5838) [#5837](https://github.com/super-linter/super-linter/issues/5837)
* fix linting errors ([#5843](https://github.com/super-linter/super-linter/issues/5843)) ([256b227](https://github.com/super-linter/super-linter/commit/256b22786d919987396d57f16ba982ee161bdf77)), closes [#5841](https://github.com/super-linter/super-linter/issues/5841) [#5842](https://github.com/super-linter/super-linter/issues/5842)
* update docs to improve build locally ([#5788](https://github.com/super-linter/super-linter/issues/5788)) ([9d154f5](https://github.com/super-linter/super-linter/commit/9d154f5e68af77bf3f7fb08a89d4cdc0552dde80))

## [6.6.0](https://github.com/super-linter/super-linter/compare/v6.5.1...v6.6.0) (2024-06-03)


### 🚀 Features

* support for `POWERSHELL_CONFIG_FILE` ([#5674](https://github.com/super-linter/super-linter/issues/5674)) ([3f56c89](https://github.com/super-linter/super-linter/commit/3f56c897a85fa2be5e763aab00a17010be31521a))


### ⬆️ Dependency updates

* **bundler:** bump rubocop-performance in /dependencies ([#5672](https://github.com/super-linter/super-linter/issues/5672)) ([cd5a7f4](https://github.com/super-linter/super-linter/commit/cd5a7f467f5e53aa73d8e87129018948a0e13805))
* **bundler:** bump rubocop-rails from 2.24.1 to 2.25.0 in /dependencies ([#5673](https://github.com/super-linter/super-linter/issues/5673)) ([4d8ee6f](https://github.com/super-linter/super-linter/commit/4d8ee6fa830a960811319b9de3da9ae1948a4637))
* **bundler:** bump rubocop-rspec from 2.29.2 to 2.30.0 in /dependencies ([#5722](https://github.com/super-linter/super-linter/issues/5722)) ([e7de5fa](https://github.com/super-linter/super-linter/commit/e7de5fae80b5e14694c72c1650e222304e9bf25c))
* **dev-docker:** bump node in /dev-dependencies ([#5666](https://github.com/super-linter/super-linter/issues/5666)) ([62955bf](https://github.com/super-linter/super-linter/commit/62955bfd61670014c166688db367266c49dcc63d))
* **docker:** bump alpine/terragrunt from 1.8.3 to 1.8.4 ([#5710](https://github.com/super-linter/super-linter/issues/5710)) ([52bb159](https://github.com/super-linter/super-linter/commit/52bb159e5ef6ffa23988f58c91f60c9aecfb594e))
* **docker:** bump clj-kondo/clj-kondo ([#5711](https://github.com/super-linter/super-linter/issues/5711)) ([50b0841](https://github.com/super-linter/super-linter/commit/50b08416e5f8ce72f31b075692c8aa42da0ecc94))
* **docker:** bump dart from 3.3.4-sdk to 3.4.0-sdk ([#5660](https://github.com/super-linter/super-linter/issues/5660)) ([b14c190](https://github.com/super-linter/super-linter/commit/b14c190a2a349956a09ef4988150fe1845876188))
* **docker:** bump dart from 3.4.0-sdk to 3.4.2-sdk ([#5721](https://github.com/super-linter/super-linter/issues/5721)) ([da283a0](https://github.com/super-linter/super-linter/commit/da283a0bdc791c11a5fcf5c3df078db0b997f40f))
* **docker:** bump dotnet/sdk ([#5718](https://github.com/super-linter/super-linter/issues/5718)) ([4d66b48](https://github.com/super-linter/super-linter/commit/4d66b48996c2966a4899b1046284ebbedc148d15))
* **docker:** bump golangci/golangci-lint from v1.57.2 to v1.58.2 ([#5661](https://github.com/super-linter/super-linter/issues/5661)) ([f5d8f30](https://github.com/super-linter/super-linter/commit/f5d8f304bd5f797971d00efdc45f1cf21ca96e7c))
* **docker:** bump golangci/golangci-lint from v1.58.2 to v1.59.0 ([#5708](https://github.com/super-linter/super-linter/issues/5708)) ([da5afae](https://github.com/super-linter/super-linter/commit/da5afae4e6de4fc543fa4a7d2d8e92ee668c4680))
* **docker:** bump goreleaser/goreleaser from v1.25.1 to v1.26.2 ([#5680](https://github.com/super-linter/super-linter/issues/5680)) ([21b7b12](https://github.com/super-linter/super-linter/commit/21b7b123b11900804bbfa12ea49a4bb545e6bab7))
* **docker:** bump hashicorp/terraform from 1.8.3 to 1.8.4 ([#5707](https://github.com/super-linter/super-linter/issues/5707)) ([f8f2b9f](https://github.com/super-linter/super-linter/commit/f8f2b9f511da0114ddc211b43bd0d4a9cbf51519))
* **docker:** bump mstruebing/editorconfig-checker from 2.7.2 to v3.0.1 ([#5619](https://github.com/super-linter/super-linter/issues/5619)) ([ce545f4](https://github.com/super-linter/super-linter/commit/ce545f46b6ec832652b4a67d6f566116643a5cd7))
* **docker:** bump rhysd/actionlint from 1.6.27 to 1.7.0 ([#5644](https://github.com/super-linter/super-linter/issues/5644)) ([ff2704e](https://github.com/super-linter/super-linter/commit/ff2704e5ed902684dacbe97903b680a4f58eee92))
* **docker:** bump rhysd/actionlint from 1.7.0 to 1.7.1 ([#5720](https://github.com/super-linter/super-linter/issues/5720)) ([86c3af0](https://github.com/super-linter/super-linter/commit/86c3af052655d786a2486abbb7c169907daa432a))
* **docker:** bump terraform-linters/tflint from v0.50.3 to v0.51.1 ([#5639](https://github.com/super-linter/super-linter/issues/5639)) ([eb81c63](https://github.com/super-linter/super-linter/commit/eb81c6322e3859281863e8a39f7696c5e4f612a1))
* **docker:** bump zricethezav/gitleaks from v8.18.2 to v8.18.3 ([#5719](https://github.com/super-linter/super-linter/issues/5719)) ([08302be](https://github.com/super-linter/super-linter/commit/08302bec051b1e3f93cba02cb474e5dc36c807ac))
* **github-actions:** bump docker/login-action from 3.1.0 to 3.2.0 ([#5714](https://github.com/super-linter/super-linter/issues/5714)) ([a6a338b](https://github.com/super-linter/super-linter/commit/a6a338bcc068e8942887365679efddf8597b470b))
* **java:** bump com.puppycrawl.tools:checkstyle ([#5706](https://github.com/super-linter/super-linter/issues/5706)) ([9b2c92d](https://github.com/super-linter/super-linter/commit/9b2c92df5b040c0867edf072804ed19aa47a59ea))
* **npm:** bump @babel/eslint-parser in /dependencies ([#5617](https://github.com/super-linter/super-linter/issues/5617)) ([9dd03d6](https://github.com/super-linter/super-linter/commit/9dd03d673729e80053cba559de56f906f47ec03b))
* **npm:** bump @babel/eslint-parser in /dependencies ([#5695](https://github.com/super-linter/super-linter/issues/5695)) ([69eb2ce](https://github.com/super-linter/super-linter/commit/69eb2ced7fbe85bd745f543a9253292cd89926af))
* **npm:** bump @babel/preset-react in /dependencies ([#5693](https://github.com/super-linter/super-linter/issues/5693)) ([d063825](https://github.com/super-linter/super-linter/commit/d06382531fa483c29fbea0132e31d7bc4f9bdbdb))
* **npm:** bump @babel/preset-typescript in /dependencies ([#5701](https://github.com/super-linter/super-linter/issues/5701)) ([adbda1b](https://github.com/super-linter/super-linter/commit/adbda1ba8345d2d8d6e33eb331f4ae69bcdc26c3))
* **npm:** bump @ibm/tekton-lint from 1.0.2 to 1.1.0 in /dependencies ([#5694](https://github.com/super-linter/super-linter/issues/5694)) ([b20c1d3](https://github.com/super-linter/super-linter/commit/b20c1d380306e50cc3758247c9248a83d6d0e34f))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5663](https://github.com/super-linter/super-linter/issues/5663)) ([e4b7555](https://github.com/super-linter/super-linter/commit/e4b75555c27973c868aab2acd511afc91725d38d))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5724](https://github.com/super-linter/super-linter/issues/5724)) ([8a93f17](https://github.com/super-linter/super-linter/commit/8a93f170c584aa1262ebe3b8dbf3c116b38454a6))
* **npm:** bump eslint-plugin-jest in /dependencies ([#5606](https://github.com/super-linter/super-linter/issues/5606)) ([c4eb4c2](https://github.com/super-linter/super-linter/commit/c4eb4c204d86e74eb131c374b47170a3b4be45fe))
* **npm:** bump eslint-plugin-json from 3.1.0 to 4.0.0 in /dependencies ([#5690](https://github.com/super-linter/super-linter/issues/5690)) ([112961f](https://github.com/super-linter/super-linter/commit/112961fc7e39c160b387ab8cb5f9a052676a863a))
* **npm:** bump eslint-plugin-jsonc in /dependencies ([#5697](https://github.com/super-linter/super-linter/issues/5697)) ([d02599f](https://github.com/super-linter/super-linter/commit/d02599f371c79a7b380cb70ac4bd63efa3a35931))
* **npm:** bump eslint-plugin-react in /dependencies ([#5725](https://github.com/super-linter/super-linter/issues/5725)) ([74da42a](https://github.com/super-linter/super-linter/commit/74da42a6fc95958e2a93b0dcbfaf752f47b22d35))
* **npm:** bump eslint-plugin-vue from 9.25.0 to 9.26.0 in /dependencies ([#5646](https://github.com/super-linter/super-linter/issues/5646)) ([eb90186](https://github.com/super-linter/super-linter/commit/eb901862bb33a50b0ec383325f24ade28978570d))
* **npm:** bump jscpd from 3.5.10 to 4.0.4 in /dependencies ([#5726](https://github.com/super-linter/super-linter/issues/5726)) ([8b554c2](https://github.com/super-linter/super-linter/commit/8b554c239825fa56b31958474343f8cd19fc0f55))
* **npm:** bump markdownlint-cli from 0.39.0 to 0.40.0 in /dependencies ([#5612](https://github.com/super-linter/super-linter/issues/5612)) ([9891996](https://github.com/super-linter/super-linter/commit/98919965350f451f3a2f7308638cffcdc7b87f4c))
* **npm:** bump markdownlint-cli from 0.40.0 to 0.41.0 in /dependencies ([#5692](https://github.com/super-linter/super-linter/issues/5692)) ([c817f65](https://github.com/super-linter/super-linter/commit/c817f656cbe0814488d0f2ac728eba02826b5244))
* **npm:** bump npm-groovy-lint from 14.5.0 to 14.6.0 in /dependencies ([#5649](https://github.com/super-linter/super-linter/issues/5649)) ([b434699](https://github.com/super-linter/super-linter/commit/b43469967ea02e6face41651e264c8c7233d0f97))
* **npm:** bump prettier from 3.2.5 to 3.3.0 in /dependencies ([#5723](https://github.com/super-linter/super-linter/issues/5723)) ([c8ba104](https://github.com/super-linter/super-linter/commit/c8ba104274e539ecb01ee36b1f7412839bdfafe6))
* **npm:** bump pug from 3.0.2 to 3.0.3 in /dependencies ([#5698](https://github.com/super-linter/super-linter/issues/5698)) ([d891845](https://github.com/super-linter/super-linter/commit/d891845a019528c7e6ac594ce1edca3315e111d3))
* **npm:** bump renovate from 37.334.3 to 37.387.0 in /dependencies ([#5729](https://github.com/super-linter/super-linter/issues/5729)) ([87e5c05](https://github.com/super-linter/super-linter/commit/87e5c0527bc2945c47bd177f01c4b0fc5c05118e))
* **npm:** bump textlint-rule-terminology in /dependencies ([#5611](https://github.com/super-linter/super-linter/issues/5611)) ([8986780](https://github.com/super-linter/super-linter/commit/8986780bf5d183bec899a9aceb056e1af2608e7a))
* **npm:** bump textlint-rule-terminology in /dependencies ([#5696](https://github.com/super-linter/super-linter/issues/5696)) ([b1ad8a0](https://github.com/super-linter/super-linter/commit/b1ad8a0f8f70005fa7c4ea9921aea9576238e289))
* **python:** bump ansible-lint in /dependencies/python ([#5671](https://github.com/super-linter/super-linter/issues/5671)) ([7be6a57](https://github.com/super-linter/super-linter/commit/7be6a577d23f30b0b8c1294a99bfcf1c18d4e960))
* **python:** bump cfn-lint in /dependencies/python ([#5668](https://github.com/super-linter/super-linter/issues/5668)) ([66a6e02](https://github.com/super-linter/super-linter/commit/66a6e02cf634f2ebd0ea908e34815e06a63c22af))
* **python:** bump cfn-lint in /dependencies/python ([#5715](https://github.com/super-linter/super-linter/issues/5715)) ([738dc05](https://github.com/super-linter/super-linter/commit/738dc051a7d5160ab43bf00cb904bab8fab4ff09))
* **python:** bump checkov in /dependencies/python ([#5717](https://github.com/super-linter/super-linter/issues/5717)) ([31c8eb9](https://github.com/super-linter/super-linter/commit/31c8eb95cf0cbba91cac7825a7f04aa70cfbe630))
* **python:** bump pylint from 3.1.0 to 3.2.2 in /dependencies/python ([#5667](https://github.com/super-linter/super-linter/issues/5667)) ([f600f49](https://github.com/super-linter/super-linter/commit/f600f4952c57a6e097686fb527349fcb0cfcfbb8))
* **python:** bump ruff from 0.4.4 to 0.4.7 in /dependencies/python ([#5716](https://github.com/super-linter/super-linter/issues/5716)) ([99efdd8](https://github.com/super-linter/super-linter/commit/99efdd8dc3f311275b34a42397650fb4ad623adf))
* **python:** bump snakemake in /dependencies/python ([#5703](https://github.com/super-linter/super-linter/issues/5703)) ([2f394ba](https://github.com/super-linter/super-linter/commit/2f394ba89673db10cc6234a452f63fe2b52822e9))
* **python:** bump sqlfluff from 3.0.6 to 3.0.7 in /dependencies/python ([#5704](https://github.com/super-linter/super-linter/issues/5704)) ([6d9fd77](https://github.com/super-linter/super-linter/commit/6d9fd77286960bde14cb57db12578967f4b29b3e))


### 🧰 Maintenance

* install lua from the os package repository ([#5655](https://github.com/super-linter/super-linter/issues/5655)) ([6af32f6](https://github.com/super-linter/super-linter/commit/6af32f65752f3d9ea7dc5e291871cef8445d95d1))
* run a job on test suite success ([#5687](https://github.com/super-linter/super-linter/issues/5687)) ([a86fbaf](https://github.com/super-linter/super-linter/commit/a86fbaf65e12e5f9901f01e01bbd74b3b54633fa)), closes [#5686](https://github.com/super-linter/super-linter/issues/5686)
* update issue form to include version info ([#5682](https://github.com/super-linter/super-linter/issues/5682)) ([e4da776](https://github.com/super-linter/super-linter/commit/e4da77657e54b09569d879fdf3be6b47474e72ce))
* update php linters ([#5689](https://github.com/super-linter/super-linter/issues/5689)) ([13f6ec2](https://github.com/super-linter/super-linter/commit/13f6ec2ffb8437b7670ae6c46f1ece7104c9a0aa))

## [6.5.1](https://github.com/super-linter/super-linter/compare/v6.5.0...v6.5.1) (2024-05-24)


### 🐛 Bugfixes

* fix a shadowing setting in .golangci.yml ([#5654](https://github.com/super-linter/super-linter/issues/5654)) ([03b4aa0](https://github.com/super-linter/super-linter/commit/03b4aa0798b7e1e4b45d918d1577ca56f634a855))


### ⬆️ Dependency updates

* **docker:** bump dotnet/sdk ([#5662](https://github.com/super-linter/super-linter/issues/5662)) ([0f6e4fb](https://github.com/super-linter/super-linter/commit/0f6e4fbf0b1b893a7326911c5a0405ea60fe5068))
* **npm:** bump react-intl from 6.6.6 to 6.6.8 in /dependencies ([#5665](https://github.com/super-linter/super-linter/issues/5665)) ([e3faa97](https://github.com/super-linter/super-linter/commit/e3faa97fecd9c4aeda996b8e023c14730e386835))
* **python:** bump checkov from 3.2.91 to 3.2.98 in /dependencies/python ([#5669](https://github.com/super-linter/super-linter/issues/5669)) ([df39abd](https://github.com/super-linter/super-linter/commit/df39abd805dc2a02adf4ea3660ec54b8783fa1c2))
* **python:** bump snakemake in /dependencies/python ([#5670](https://github.com/super-linter/super-linter/issues/5670)) ([457e0f5](https://github.com/super-linter/super-linter/commit/457e0f58c96006c15a91ba0775ad1ba0912641f5))


### 🧰 Maintenance

* move local action test to a dedicated job ([#5629](https://github.com/super-linter/super-linter/issues/5629)) ([90f3fef](https://github.com/super-linter/super-linter/commit/90f3fef29d4e463c132fabc263ce4583bf1d0426))
* update gitlab and azure docs ([#5677](https://github.com/super-linter/super-linter/issues/5677)) ([c5e4fe1](https://github.com/super-linter/super-linter/commit/c5e4fe14a1931d1aacb0c36a1d56e586e6744030))

## [6.5.0](https://github.com/super-linter/super-linter/compare/v6.4.1...v6.5.0) (2024-05-15)


### 🚀 Features

* find go.mod based on Go files ([#5345](https://github.com/super-linter/super-linter/issues/5345)) ([f84508a](https://github.com/super-linter/super-linter/commit/f84508a9c420fbf52942c9ba8761e217381345c3))
* ignore avif files when building file list ([#5604](https://github.com/super-linter/super-linter/issues/5604)) ([6047e3f](https://github.com/super-linter/super-linter/commit/6047e3f732ceff4c86ae4bf545e0fb57a07c2d1d)), closes [#5382](https://github.com/super-linter/super-linter/issues/5382)
* support arbitrary shellcheck config paths ([#5571](https://github.com/super-linter/super-linter/issues/5571)) ([c26430f](https://github.com/super-linter/super-linter/commit/c26430f868da45c64a4271051a2797adf61e8c9a)), closes [#5414](https://github.com/super-linter/super-linter/issues/5414)


### 🐛 Bugfixes

* no full git validation when ignoring files ([5b0c248](https://github.com/super-linter/super-linter/commit/5b0c248f9c59d9a50a584958c961ae30c0aa1393)), closes [#5383](https://github.com/super-linter/super-linter/issues/5383)
* no full git validation when ignoring files ([#5599](https://github.com/super-linter/super-linter/issues/5599)) ([2bb8a0a](https://github.com/super-linter/super-linter/commit/2bb8a0a3e773ef13909830e24a0a75af839da315)), closes [#5383](https://github.com/super-linter/super-linter/issues/5383)


### ⬆️ Dependency updates

* **bundler:** bump rubocop-rspec from 2.29.1 to 2.29.2 in /dependencies ([#5625](https://github.com/super-linter/super-linter/issues/5625)) ([ce42697](https://github.com/super-linter/super-linter/commit/ce42697596f40f366fdad6d62b96bab68a6a7c83))
* **dev-docker:** bump node in /dev-dependencies ([#5613](https://github.com/super-linter/super-linter/issues/5613)) ([1f7fc1c](https://github.com/super-linter/super-linter/commit/1f7fc1cd3c25dfb6276a64d5bd79d10c916a9348))
* **dev-npm:** bump @commitlint/cli in /dev-dependencies ([#5585](https://github.com/super-linter/super-linter/issues/5585)) ([fc019a7](https://github.com/super-linter/super-linter/commit/fc019a70aee7f1cb1c9008fb55e436994862aedd))
* **dev-npm:** bump @commitlint/config-conventional in /dev-dependencies ([#5521](https://github.com/super-linter/super-linter/issues/5521)) ([5336115](https://github.com/super-linter/super-linter/commit/53361158a1cdd3b7660986e00d8635147970e842))
* **dev-npm:** bump release-please in /dev-dependencies ([#5566](https://github.com/super-linter/super-linter/issues/5566)) ([11691a0](https://github.com/super-linter/super-linter/commit/11691a06ed8b75b7e201ff4d4880191bf6690941))
* **docker:** bump alpine/terragrunt from 1.8.0 to 1.8.1 ([#5552](https://github.com/super-linter/super-linter/issues/5552)) ([1682dbc](https://github.com/super-linter/super-linter/commit/1682dbc599cd05ff943da206364f47e42ea98d6c))
* **docker:** bump alpine/terragrunt from 1.8.1 to 1.8.2 ([#5588](https://github.com/super-linter/super-linter/issues/5588)) ([865d249](https://github.com/super-linter/super-linter/commit/865d249bf43c0dcfb467079861777102f2fb3e34))
* **docker:** bump alpine/terragrunt from 1.8.2 to 1.8.3 ([#5640](https://github.com/super-linter/super-linter/issues/5640)) ([04b0e6a](https://github.com/super-linter/super-linter/commit/04b0e6a62bac0e649c53081020b0078e5b0afcfc))
* **docker:** bump dart from 3.3.3-sdk to 3.3.4-sdk ([#5550](https://github.com/super-linter/super-linter/issues/5550)) ([a540e8d](https://github.com/super-linter/super-linter/commit/a540e8d30d87a6176013cb937395ef0291e62457))
* **docker:** bump golang from 1.22.2-alpine to 1.22.3-alpine ([#5645](https://github.com/super-linter/super-linter/issues/5645)) ([36bdc9b](https://github.com/super-linter/super-linter/commit/36bdc9b8bde11931755c783178c8dfc0a8535944))
* **docker:** bump hashicorp/terraform from 1.8.0 to 1.8.1 ([#5551](https://github.com/super-linter/super-linter/issues/5551)) ([74733ba](https://github.com/super-linter/super-linter/commit/74733ba0a4f8a80f098968204ecb912a550d7528))
* **docker:** bump hashicorp/terraform from 1.8.1 to 1.8.2 ([#5589](https://github.com/super-linter/super-linter/issues/5589)) ([4708a27](https://github.com/super-linter/super-linter/commit/4708a27d64996945fdaa07dc6b3f2405db432202))
* **docker:** bump hashicorp/terraform from 1.8.2 to 1.8.3 ([#5638](https://github.com/super-linter/super-linter/issues/5638)) ([f9c580f](https://github.com/super-linter/super-linter/commit/f9c580ff9aad144f780b8a1358ccf33cd28dca4b))
* **docker:** bump yannh/kubeconform from v0.6.4 to v0.6.6 ([#5643](https://github.com/super-linter/super-linter/issues/5643)) ([f9c6ce7](https://github.com/super-linter/super-linter/commit/f9c6ce7eba8008b7176872e15fbd08fe10c2138b))
* **docker:** bump yoheimuta/protolint from 0.49.6 to 0.49.7 ([#5618](https://github.com/super-linter/super-linter/issues/5618)) ([bf8280c](https://github.com/super-linter/super-linter/commit/bf8280c30317dc31f91714d102843514237e4099))
* **github-actions:** bump actions/download-artifact from 4.1.4 to 4.1.5 ([#5553](https://github.com/super-linter/super-linter/issues/5553)) ([90554b4](https://github.com/super-linter/super-linter/commit/90554b436d184e59827403bda7e0b1f36b8e6995))
* **github-actions:** bump actions/download-artifact from 4.1.5 to 4.1.7 ([#5587](https://github.com/super-linter/super-linter/issues/5587)) ([5d2a841](https://github.com/super-linter/super-linter/commit/5d2a841f25f4915a9d487ef0d19622b6a585e38d))
* **github-actions:** bump actions/upload-artifact from 4.3.1 to 4.3.2 ([#5554](https://github.com/super-linter/super-linter/issues/5554)) ([46a0678](https://github.com/super-linter/super-linter/commit/46a0678d46fcb415aeecf62811f7acd01f862975))
* **github-actions:** bump actions/upload-artifact from 4.3.2 to 4.3.3 ([#5586](https://github.com/super-linter/super-linter/issues/5586)) ([2b7fe0e](https://github.com/super-linter/super-linter/commit/2b7fe0e1c71eb0ff4a241c90fa12942bcde31d33))
* **java:** bump com.puppycrawl.tools:checkstyle ([#5577](https://github.com/super-linter/super-linter/issues/5577)) ([ee3d6a3](https://github.com/super-linter/super-linter/commit/ee3d6a341853a8aedfac7b11ed6210d75be64495))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5561](https://github.com/super-linter/super-linter/issues/5561)) ([9416109](https://github.com/super-linter/super-linter/commit/9416109904d44bb50b64029037eec9461a520936))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5596](https://github.com/super-linter/super-linter/issues/5596)) ([c84ccab](https://github.com/super-linter/super-linter/commit/c84ccaba7b2d9248906808d2e5c9da06608e967f))
* **npm:** bump eslint-plugin-jest in /dependencies ([#5592](https://github.com/super-linter/super-linter/issues/5592)) ([b74078c](https://github.com/super-linter/super-linter/commit/b74078c5a6f875be9b0b3fe6588d3bb7aa36914d))
* **npm:** bump eslint-plugin-react-hooks in /dependencies ([#5591](https://github.com/super-linter/super-linter/issues/5591)) ([4db046c](https://github.com/super-linter/super-linter/commit/4db046cc976dd6872186af160e279c34fdf12664))
* **npm:** bump next from 14.2.1 to 14.2.2 in /dependencies ([#5563](https://github.com/super-linter/super-linter/issues/5563)) ([052892b](https://github.com/super-linter/super-linter/commit/052892b1f70f90946623788a879dccf237c54974))
* **npm:** bump next from 14.2.2 to 14.2.3 in /dependencies ([#5590](https://github.com/super-linter/super-linter/issues/5590)) ([c32a933](https://github.com/super-linter/super-linter/commit/c32a933b8a0b360cc16a52be9692120cc292d3c1))
* **npm:** bump npm-groovy-lint from 14.4.0 to 14.4.1 in /dependencies ([#5565](https://github.com/super-linter/super-linter/issues/5565)) ([9cce54a](https://github.com/super-linter/super-linter/commit/9cce54a9e89da728a4ab57e1dbed660251c63088))
* **npm:** bump npm-groovy-lint from 14.4.1 to 14.5.0 in /dependencies ([#5598](https://github.com/super-linter/super-linter/issues/5598)) ([311beb3](https://github.com/super-linter/super-linter/commit/311beb3d58a7f771d959a6410cdbe4b0b9d7f002))
* **npm:** bump react from 18.2.0 to 18.3.1 in /dependencies ([#5594](https://github.com/super-linter/super-linter/issues/5594)) ([ea225c4](https://github.com/super-linter/super-linter/commit/ea225c4c10f8dfc85a7c7409ec38609b8adde276))
* **npm:** bump react-dom from 18.2.0 to 18.3.1 in /dependencies ([#5593](https://github.com/super-linter/super-linter/issues/5593)) ([aceb5ca](https://github.com/super-linter/super-linter/commit/aceb5ca4775298499205ef580043cda1c29c75a8))
* **npm:** bump react-intl from 6.6.5 to 6.6.6 in /dependencies ([#5609](https://github.com/super-linter/super-linter/issues/5609)) ([391a241](https://github.com/super-linter/super-linter/commit/391a2416c88225c5996aee8a15da741f219eb940))
* **npm:** bump react-redux from 9.1.1 to 9.1.2 in /dependencies ([#5608](https://github.com/super-linter/super-linter/issues/5608)) ([1c0a02f](https://github.com/super-linter/super-linter/commit/1c0a02f58bdd7e0db599e0617ebc48e1480765fb))
* **npm:** bump react-router-dom from 6.22.3 to 6.23.0 in /dependencies ([#5597](https://github.com/super-linter/super-linter/issues/5597)) ([2b32556](https://github.com/super-linter/super-linter/commit/2b32556eba4cc6071005e5aed9625282a4e91f32))
* **npm:** bump react-router-dom from 6.23.0 to 6.23.1 in /dependencies ([#5647](https://github.com/super-linter/super-linter/issues/5647)) ([ce95ff0](https://github.com/super-linter/super-linter/commit/ce95ff054f57057de9baecd1a5038f2cc0cc7b76))
* **npm:** bump renovate from 37.296.0 to 37.317.0 in /dependencies ([#5562](https://github.com/super-linter/super-linter/issues/5562)) ([a831c47](https://github.com/super-linter/super-linter/commit/a831c47e7e49dd4f838bacccd18b4bcea3884db9))
* **npm:** bump renovate from 37.317.0 to 37.334.3 in /dependencies ([#5603](https://github.com/super-linter/super-linter/issues/5603)) ([5bcb838](https://github.com/super-linter/super-linter/commit/5bcb83888bf521239127441cae7cfc76048d0ce5))
* **python:** bump ansible-lint in /dependencies/python ([#5624](https://github.com/super-linter/super-linter/issues/5624)) ([539d775](https://github.com/super-linter/super-linter/commit/539d775452bdd1e497e590456715e08e5458ff19))
* **python:** bump black from 24.4.0 to 24.4.2 in /dependencies/python ([#5582](https://github.com/super-linter/super-linter/issues/5582)) ([f4c1237](https://github.com/super-linter/super-linter/commit/f4c12373fb48a6c4934c5cad49a7aef956b44f33))
* **python:** bump cfn-lint in /dependencies/python ([#5556](https://github.com/super-linter/super-linter/issues/5556)) ([72d4e76](https://github.com/super-linter/super-linter/commit/72d4e765fba4e0d0d8284abaf2963e8305bdf158))
* **python:** bump cfn-lint in /dependencies/python ([#5579](https://github.com/super-linter/super-linter/issues/5579)) ([0493846](https://github.com/super-linter/super-linter/commit/0493846727be6e30751952b2c1ef687194f1275c))
* **python:** bump checkov from 3.2.65 to 3.2.73 in /dependencies/python ([#5559](https://github.com/super-linter/super-linter/issues/5559)) ([cd1b819](https://github.com/super-linter/super-linter/commit/cd1b81991663c9489cd0be741beeaf98be80578c))
* **python:** bump checkov from 3.2.73 to 3.2.74 in /dependencies/python ([#5581](https://github.com/super-linter/super-linter/issues/5581)) ([b5fc3e0](https://github.com/super-linter/super-linter/commit/b5fc3e0bc18814d3fcab139097da4834e68184ea))
* **python:** bump checkov from 3.2.74 to 3.2.91 in /dependencies/python ([#5634](https://github.com/super-linter/super-linter/issues/5634)) ([e11060e](https://github.com/super-linter/super-linter/commit/e11060e61b73ec7db9c46f2607bfb184a40d7706))
* **python:** bump mypy from 1.9.0 to 1.10.0 in /dependencies/python ([#5583](https://github.com/super-linter/super-linter/issues/5583)) ([a879108](https://github.com/super-linter/super-linter/commit/a8791089c08389402635eca0c19590f874e3a643))
* **python:** bump ruff from 0.3.7 to 0.4.1 in /dependencies/python ([#5560](https://github.com/super-linter/super-linter/issues/5560)) ([7e7da7a](https://github.com/super-linter/super-linter/commit/7e7da7ad369c85feee149b7ee237fef558bac5a3))
* **python:** bump ruff from 0.4.1 to 0.4.2 in /dependencies/python ([#5580](https://github.com/super-linter/super-linter/issues/5580)) ([a68decb](https://github.com/super-linter/super-linter/commit/a68decb78f87117632cef327aec1e303bc2119e1))
* **python:** bump ruff from 0.4.2 to 0.4.4 in /dependencies/python ([#5633](https://github.com/super-linter/super-linter/issues/5633)) ([5ac1cf3](https://github.com/super-linter/super-linter/commit/5ac1cf3c96079a09c88caa97f1fe6c27c8177487))
* **python:** bump snakefmt in /dependencies/python ([#5632](https://github.com/super-linter/super-linter/issues/5632)) ([61139b4](https://github.com/super-linter/super-linter/commit/61139b43b60cfffb9bcf1645ed05cdce88f7b758))
* **python:** bump snakemake in /dependencies/python ([#5558](https://github.com/super-linter/super-linter/issues/5558)) ([02a63e9](https://github.com/super-linter/super-linter/commit/02a63e98cf700af931b6cb1383cb461e53b4633c))
* **python:** bump snakemake in /dependencies/python ([#5584](https://github.com/super-linter/super-linter/issues/5584)) ([5c3f218](https://github.com/super-linter/super-linter/commit/5c3f218ac3e543d8989601dfb4eac52cdbd67e1c))
* **python:** bump snakemake in /dependencies/python ([#5635](https://github.com/super-linter/super-linter/issues/5635)) ([a08197e](https://github.com/super-linter/super-linter/commit/a08197ea80b9f1660637ae785e260a808fad929d))
* **python:** bump sqlfluff from 3.0.4 to 3.0.5 in /dependencies/python ([#5557](https://github.com/super-linter/super-linter/issues/5557)) ([0cbc4d9](https://github.com/super-linter/super-linter/commit/0cbc4d9c8d8fead38c826f9796bb7b6cb2d84de4))
* **python:** bump sqlfluff from 3.0.5 to 3.0.6 in /dependencies/python ([#5637](https://github.com/super-linter/super-linter/issues/5637)) ([00bc9da](https://github.com/super-linter/super-linter/commit/00bc9da9d19d9c3a5c316196e00d7d5cf2d28584))
* **python:** bump yq from 3.3.0 to 3.4.1 in /dependencies/python ([#5555](https://github.com/super-linter/super-linter/issues/5555)) ([f33d4b2](https://github.com/super-linter/super-linter/commit/f33d4b288450b6327b67e409019c05f0281f2853))
* **python:** bump yq from 3.4.1 to 3.4.3 in /dependencies/python ([#5578](https://github.com/super-linter/super-linter/issues/5578)) ([7c0630a](https://github.com/super-linter/super-linter/commit/7c0630af44dd2975ab80a32004076e3473bb911c))


### 🧰 Maintenance

* remove deployment configuration from ci ([#5628](https://github.com/super-linter/super-linter/issues/5628)) ([e0c8376](https://github.com/super-linter/super-linter/commit/e0c8376c3a00ff1c28e14f8e66295946f1c516fa))

## [6.4.1](https://github.com/super-linter/super-linter/compare/v6.4.0...v6.4.1) (2024-04-22)


### 🐛 Bugfixes

* configure ruff with a temp cache ([#5548](https://github.com/super-linter/super-linter/issues/5548)) ([56e675b](https://github.com/super-linter/super-linter/commit/56e675bd333f8af069b2d7ba67ade1f39fcd01c4)), closes [#5543](https://github.com/super-linter/super-linter/issues/5543)
* handle initial commit ([#5534](https://github.com/super-linter/super-linter/issues/5534)) ([8f405c1](https://github.com/super-linter/super-linter/commit/8f405c1a9cbb85e113ceed34bc3814f9800b2168)), closes [#5453](https://github.com/super-linter/super-linter/issues/5453)
* respect log level when writing to the log ([#5546](https://github.com/super-linter/super-linter/issues/5546)) ([49001a2](https://github.com/super-linter/super-linter/commit/49001a24050aa95099353e3f14e8854b1196450f)), closes [#5337](https://github.com/super-linter/super-linter/issues/5337)
* wrap version info and logo with logs ([#5547](https://github.com/super-linter/super-linter/issues/5547)) ([bd56ae5](https://github.com/super-linter/super-linter/commit/bd56ae560840642eb0b558c5febecc28d2e8401d)), closes [#5337](https://github.com/super-linter/super-linter/issues/5337)


### ⬆️ Dependency updates

* **dev-docker:** bump node in /dev-dependencies ([#5512](https://github.com/super-linter/super-linter/issues/5512)) ([155f3a6](https://github.com/super-linter/super-linter/commit/155f3a6419c722dc839ca6f831b924ec4a424610))
* **dev-npm:** bump @commitlint/cli in /dev-dependencies ([#5522](https://github.com/super-linter/super-linter/issues/5522)) ([ed458ca](https://github.com/super-linter/super-linter/commit/ed458ca1ddcef14d1e488a2aea1e3c6cf63cbcc9))
* **docker:** bump alpine/terragrunt from 1.7.5 to 1.8.0 ([#5507](https://github.com/super-linter/super-linter/issues/5507)) ([9f4f94e](https://github.com/super-linter/super-linter/commit/9f4f94e8ff0930ac0d1f721a088ced8d8477b7c1))
* **docker:** bump dotnet/sdk ([#5508](https://github.com/super-linter/super-linter/issues/5508)) ([c09c7a3](https://github.com/super-linter/super-linter/commit/c09c7a3efc2fe022cf43386bec0184976ee40e63))
* **docker:** bump hashicorp/terraform from 1.7.5 to 1.8.0 ([#5510](https://github.com/super-linter/super-linter/issues/5510)) ([c65f44c](https://github.com/super-linter/super-linter/commit/c65f44c2867e2a81de9a0268adee04406e871aab))
* **docker:** bump python from 3.12.2-alpine3.19 to 3.12.3-alpine3.19 ([#5511](https://github.com/super-linter/super-linter/issues/5511)) ([a7d84ea](https://github.com/super-linter/super-linter/commit/a7d84ea6c8a35f1463ed844a24cb54caee0a78bd))
* **docker:** bump yoheimuta/protolint from 0.49.4 to 0.49.6 ([#5509](https://github.com/super-linter/super-linter/issues/5509)) ([0b280e4](https://github.com/super-linter/super-linter/commit/0b280e4a9afee6eee68d2edce4f6a0db0172f470))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5515](https://github.com/super-linter/super-linter/issues/5515)) ([afe0821](https://github.com/super-linter/super-linter/commit/afe0821d324a1256b9e5b6d9fd3a2b0e618e06f4))
* **npm:** bump eslint-plugin-jsonc in /dependencies ([#5514](https://github.com/super-linter/super-linter/issues/5514)) ([2c2ce27](https://github.com/super-linter/super-linter/commit/2c2ce27da676bfb878e1e29607a6792dc1dfc858))
* **npm:** bump eslint-plugin-vue from 9.24.1 to 9.25.0 in /dependencies ([#5516](https://github.com/super-linter/super-linter/issues/5516)) ([77f9363](https://github.com/super-linter/super-linter/commit/77f9363f9ef301006542628d3fbeeb21afe95272))
* **npm:** bump next from 14.1.4 to 14.2.1 in /dependencies ([#5513](https://github.com/super-linter/super-linter/issues/5513)) ([041abfb](https://github.com/super-linter/super-linter/commit/041abfb79a8b84aa8a961684c8e6580683bfce6e))
* **npm:** bump react-redux from 9.1.0 to 9.1.1 in /dependencies ([#5520](https://github.com/super-linter/super-linter/issues/5520)) ([632b571](https://github.com/super-linter/super-linter/commit/632b571bbb2a30040352036038d8f8c6bdcf211a))
* **npm:** bump renovate from 37.280.0 to 37.296.0 in /dependencies ([#5518](https://github.com/super-linter/super-linter/issues/5518)) ([338a2bc](https://github.com/super-linter/super-linter/commit/338a2bc195b7013a215bc6ef7aae6c0712774402))
* **npm:** bump typescript from 5.4.4 to 5.4.5 in /dependencies ([#5519](https://github.com/super-linter/super-linter/issues/5519)) ([9d10c26](https://github.com/super-linter/super-linter/commit/9d10c26c5bacfb1375984ca106381497425d5a58))
* **python:** bump ansible-lint in /dependencies/python ([#5529](https://github.com/super-linter/super-linter/issues/5529)) ([5cc9442](https://github.com/super-linter/super-linter/commit/5cc9442514d4e48cc4b3e5b4881e97a785b1d64c))
* **python:** bump black from 24.3.0 to 24.4.0 in /dependencies/python ([#5525](https://github.com/super-linter/super-linter/issues/5525)) ([48c98aa](https://github.com/super-linter/super-linter/commit/48c98aa1507adb50e60d95491480802c615fdeec))
* **python:** bump checkov from 3.2.55 to 3.2.65 in /dependencies/python ([#5527](https://github.com/super-linter/super-linter/issues/5527)) ([3d5d68f](https://github.com/super-linter/super-linter/commit/3d5d68fa10c83fe4539d34d8ffac50dfd0fc8735))
* **python:** bump ruff from 0.3.4 to 0.3.7 in /dependencies/python ([#5528](https://github.com/super-linter/super-linter/issues/5528)) ([afaeb3a](https://github.com/super-linter/super-linter/commit/afaeb3acbc607cc6fc87d7edce3529991c17d507))
* **python:** bump snakefmt in /dependencies/python ([#5526](https://github.com/super-linter/super-linter/issues/5526)) ([8b76d91](https://github.com/super-linter/super-linter/commit/8b76d91fb3ad051975f4d9500c4b05a6fdeb35e4))
* **python:** bump snakemake in /dependencies/python ([#5523](https://github.com/super-linter/super-linter/issues/5523)) ([fdd0427](https://github.com/super-linter/super-linter/commit/fdd042766f3ce77de83e7ee2494a1cab44dfab49))
* **python:** bump sqlfluff from 3.0.3 to 3.0.4 in /dependencies/python ([#5530](https://github.com/super-linter/super-linter/issues/5530)) ([a0e8621](https://github.com/super-linter/super-linter/commit/a0e8621c3cc8cdc3315501aaaa089ef674eca82f))
* **python:** bump yq from 3.2.3 to 3.3.0 in /dependencies/python ([#5524](https://github.com/super-linter/super-linter/issues/5524)) ([1c603c7](https://github.com/super-linter/super-linter/commit/1c603c70267c75d7950a30aa2f83147f4b4a71d1))


### 🧰 Maintenance

* **deps:** bump golang.org/x/net ([#5544](https://github.com/super-linter/super-linter/issues/5544)) ([2baa96f](https://github.com/super-linter/super-linter/commit/2baa96f9a916f3b9c46fc1a1d3cb03626f46b447))
* **deps:** bump golang.org/x/net ([#5545](https://github.com/super-linter/super-linter/issues/5545)) ([7cbf4f8](https://github.com/super-linter/super-linter/commit/7cbf4f86622b97837dcab2026b780c6f06fa4352))
* fix "Goreleser" typo in README ([#5538](https://github.com/super-linter/super-linter/issues/5538)) ([e1f7bfd](https://github.com/super-linter/super-linter/commit/e1f7bfdc2503d5b61446377ce5fd6eaba97b326e))

## [6.4.0](https://github.com/super-linter/super-linter/compare/v6.3.1...v6.4.0) (2024-04-16)


### 🚀 Features

* add clang-format style configuration ([#5424](https://github.com/super-linter/super-linter/issues/5424)) ([0ae4572](https://github.com/super-linter/super-linter/commit/0ae457287495a435b3128c364e44ece8b145c47a))
* add support for astral-sh/ruff (https://github.com/super-linter/super-linter/pull/5456), closes [#5384](https://github.com/super-linter/super-linter/issues/5384) ([e71a37d](https://github.com/super-linter/super-linter/commit/e71a37d49d588b33a0d6e10f364a682e7704460e))
* support GoReleaser ([#5505](https://github.com/super-linter/super-linter/issues/5505)) ([6924988](https://github.com/super-linter/super-linter/commit/69249882f317128fb04a46d20bc8b1e289d5042a))


### 🐛 Bugfixes

* export test_case_run ([#5499](https://github.com/super-linter/super-linter/issues/5499)) ([cb109f4](https://github.com/super-linter/super-linter/commit/cb109f45f142b31b9c5e4796dbba383f662e1ff7)), closes [#5483](https://github.com/super-linter/super-linter/issues/5483)
* revert python_isort/python_bad_1.py ([ca2a416](https://github.com/super-linter/super-linter/commit/ca2a4167b8c0dbf2510b98cc41c470c9bd6f5621))
* test/linters/python_*/** ([#5502](https://github.com/super-linter/super-linter/issues/5502)) ([ca2a416](https://github.com/super-linter/super-linter/commit/ca2a4167b8c0dbf2510b98cc41c470c9bd6f5621))


### ⬆️ Dependency updates

* **bundler:** bump rubocop-rails from 2.24.0 to 2.24.1 in /dependencies ([#5443](https://github.com/super-linter/super-linter/issues/5443)) ([2a147fa](https://github.com/super-linter/super-linter/commit/2a147fa3e380c2e8e8dff7830e008c6eb36ed507))
* **bundler:** bump rubocop-rspec from 2.27.1 to 2.29.1 in /dependencies ([#5476](https://github.com/super-linter/super-linter/issues/5476)) ([5fe65e5](https://github.com/super-linter/super-linter/commit/5fe65e52cea8413e93b5144259a8a19b3f1a29c8))
* **dev-docker:** bump node in /dev-dependencies ([#5487](https://github.com/super-linter/super-linter/issues/5487)) ([aaf5f3d](https://github.com/super-linter/super-linter/commit/aaf5f3df0f6429b1b6d9365dbd935f90f5565e0e))
* **dev-npm:** bump @commitlint/cli in /dev-dependencies ([#5448](https://github.com/super-linter/super-linter/issues/5448)) ([6992ae7](https://github.com/super-linter/super-linter/commit/6992ae711886b63ffb82ab2eb9070469a1637851))
* **docker:** bump dart from 3.3.1-sdk to 3.3.3-sdk ([#5461](https://github.com/super-linter/super-linter/issues/5461)) ([41f1f2d](https://github.com/super-linter/super-linter/commit/41f1f2d22fe66f5b922aa6b79334f78efca6d814))
* **docker:** bump dotnet/sdk ([#5464](https://github.com/super-linter/super-linter/issues/5464)) ([4edb99e](https://github.com/super-linter/super-linter/commit/4edb99eac9ae056cdb809adc23ea04bf35192b93))
* **docker:** bump golang from 1.22.1-alpine to 1.22.2-alpine ([#5488](https://github.com/super-linter/super-linter/issues/5488)) ([e9d3471](https://github.com/super-linter/super-linter/commit/e9d347187e51f27d6c90793ee40600ec5fbfba46))
* **docker:** bump golangci/golangci-lint from v1.56.2 to v1.57.2 ([#5462](https://github.com/super-linter/super-linter/issues/5462)) ([0764966](https://github.com/super-linter/super-linter/commit/0764966580dcdc849c73690e084498605a444da2))
* **docker:** bump scalameta/scalafmt from v3.8.0 to v3.8.1 ([#5463](https://github.com/super-linter/super-linter/issues/5463)) ([613d661](https://github.com/super-linter/super-linter/commit/613d6614482fd8f3cc9fcbec581bbd16e8899a7a))
* **docker:** bump yoheimuta/protolint from 0.49.3 to 0.49.4 ([#5490](https://github.com/super-linter/super-linter/issues/5490)) ([62a763d](https://github.com/super-linter/super-linter/commit/62a763d7484bf4f9e51f126a86a149223d8e4d9f))
* **github-actions:** bump bobheadxi/deployments from 1.4.0 to 1.5.0 ([#5460](https://github.com/super-linter/super-linter/issues/5460)) ([fd2c7cc](https://github.com/super-linter/super-linter/commit/fd2c7cc16ebbb08e1840788c02ab735aff929cd0))
* **github-actions:** bump dependabot/fetch-metadata from 1 to 2 ([#5449](https://github.com/super-linter/super-linter/issues/5449)) ([b1e59ed](https://github.com/super-linter/super-linter/commit/b1e59ed1d42da087bd657453ee122a46651f85f9))
* **java:** bump com.google.googlejavaformat:google-java-format ([#5484](https://github.com/super-linter/super-linter/issues/5484)) ([4bc39d7](https://github.com/super-linter/super-linter/commit/4bc39d75018c3277466eefdebc286e9194965c9a))
* **java:** bump com.puppycrawl.tools:checkstyle ([#5457](https://github.com/super-linter/super-linter/issues/5457)) ([25cb7af](https://github.com/super-linter/super-linter/commit/25cb7af49d6692dbcb04aa2482544daa6b626c48))
* **npm:** bump @babel/eslint-parser in /dependencies ([#5434](https://github.com/super-linter/super-linter/issues/5434)) ([ebf7ad0](https://github.com/super-linter/super-linter/commit/ebf7ad0f3fed44978693e41b80bb1854f84a642e))
* **npm:** bump @babel/preset-react in /dependencies ([#5440](https://github.com/super-linter/super-linter/issues/5440)) ([809f6f4](https://github.com/super-linter/super-linter/commit/809f6f4abd371f2b0fb8d21e826748b5f3313843))
* **npm:** bump @babel/preset-typescript in /dependencies ([#5439](https://github.com/super-linter/super-linter/issues/5439)) ([87fe03b](https://github.com/super-linter/super-linter/commit/87fe03bc27ae5d2a07d9f80028fc763a9c9e85ef))
* **npm:** bump @ibm/tekton-lint from 1.0.1 to 1.0.2 in /dependencies ([#5485](https://github.com/super-linter/super-linter/issues/5485)) ([b26cd9f](https://github.com/super-linter/super-linter/commit/b26cd9f7e66e43f8b54647a01582bd55ad447a60))
* **npm:** bump @stoplight/spectral-cli in /dependencies ([#5492](https://github.com/super-linter/super-linter/issues/5492)) ([240e382](https://github.com/super-linter/super-linter/commit/240e3829ef1e9baf2c20468a2dce8fbd2efb40fb))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5475](https://github.com/super-linter/super-linter/issues/5475)) ([019fa5f](https://github.com/super-linter/super-linter/commit/019fa5f6cefbd543c480b335346938af6b53a7e5))
* **npm:** bump eslint-plugin-jest in /dependencies ([#5495](https://github.com/super-linter/super-linter/issues/5495)) ([5db715d](https://github.com/super-linter/super-linter/commit/5db715d2423c04cae5ec766db6941d2799d8fb4c))
* **npm:** bump eslint-plugin-jsonc in /dependencies ([#5468](https://github.com/super-linter/super-linter/issues/5468)) ([f3d13bd](https://github.com/super-linter/super-linter/commit/f3d13bd6a2a39f1f8ac69f070bfc3416d493cfa2))
* **npm:** bump eslint-plugin-vue from 9.23.0 to 9.24.0 in /dependencies ([#5438](https://github.com/super-linter/super-linter/issues/5438)) ([89e55ba](https://github.com/super-linter/super-linter/commit/89e55ba7231d7e54ae5355909fbf21195e68d491))
* **npm:** bump eslint-plugin-vue from 9.24.0 to 9.24.1 in /dependencies ([#5489](https://github.com/super-linter/super-linter/issues/5489)) ([454e13a](https://github.com/super-linter/super-linter/commit/454e13a49a71e383036847f304d18eefa1ea943a))
* **npm:** bump next from 14.1.3 to 14.1.4 in /dependencies ([#5442](https://github.com/super-linter/super-linter/issues/5442)) ([9f97afa](https://github.com/super-linter/super-linter/commit/9f97afa529f1218d8c97478018a638da563ca074))
* **npm:** bump npm-groovy-lint from 14.2.4 to 14.4.0 in /dependencies ([#5469](https://github.com/super-linter/super-linter/issues/5469)) ([1eb4e8e](https://github.com/super-linter/super-linter/commit/1eb4e8edfa0ba5dbcf99f09b36f7f81f50927ee2))
* **npm:** bump react-intl from 6.6.2 to 6.6.4 in /dependencies ([#5470](https://github.com/super-linter/super-linter/issues/5470)) ([f9f8fdd](https://github.com/super-linter/super-linter/commit/f9f8fdd6e8c696e7796f8713d01f928bbb89895d))
* **npm:** bump react-intl from 6.6.4 to 6.6.5 in /dependencies ([#5493](https://github.com/super-linter/super-linter/issues/5493)) ([702428a](https://github.com/super-linter/super-linter/commit/702428a6d9ff3a6d3fb688628905f6672284dc5e))
* **npm:** bump renovate from 37.263.0 to 37.279.0 in /dependencies ([#5466](https://github.com/super-linter/super-linter/issues/5466)) ([f059252](https://github.com/super-linter/super-linter/commit/f0592520a15628dd65b52c76648b94e02ca1e03f))
* **npm:** bump renovate from 37.279.0 to 37.280.0 in /dependencies ([#5486](https://github.com/super-linter/super-linter/issues/5486)) ([2ef03bc](https://github.com/super-linter/super-linter/commit/2ef03bce419d0ed18ce2bc9d157612507521e827))
* **npm:** bump typescript from 5.4.2 to 5.4.3 in /dependencies ([#5435](https://github.com/super-linter/super-linter/issues/5435)) ([7200949](https://github.com/super-linter/super-linter/commit/7200949541d76a6c9fbeda068d22dddc7fc67898))
* **npm:** bump typescript from 5.4.3 to 5.4.4 in /dependencies ([#5491](https://github.com/super-linter/super-linter/issues/5491)) ([1d9123e](https://github.com/super-linter/super-linter/commit/1d9123e41787280f321564ad83afb1643ad78523))
* **python:** bump cfn-lint in /dependencies/python ([#5444](https://github.com/super-linter/super-linter/issues/5444)) ([1f27242](https://github.com/super-linter/super-linter/commit/1f2724267c682e766f37c4e16c5935b309d87f5d))
* **python:** bump cfn-lint in /dependencies/python ([#5497](https://github.com/super-linter/super-linter/issues/5497)) ([7a1a2f6](https://github.com/super-linter/super-linter/commit/7a1a2f6a53662f3914a9733a3713eaa9b9273789))
* **python:** bump checkov from 3.2.39 to 3.2.50 in /dependencies/python ([#5458](https://github.com/super-linter/super-linter/issues/5458)) ([bb50b58](https://github.com/super-linter/super-linter/commit/bb50b58eca8b294d485d719bb97ebf83d506bd82))
* **python:** bump checkov from 3.2.50 to 3.2.55 in /dependencies/python ([#5494](https://github.com/super-linter/super-linter/issues/5494)) ([30cb57b](https://github.com/super-linter/super-linter/commit/30cb57b139f07a9672819eac7a1b2c0e197ae96b))
* **python:** bump snakemake in /dependencies/python ([#5459](https://github.com/super-linter/super-linter/issues/5459)) ([d86761c](https://github.com/super-linter/super-linter/commit/d86761cc6a052697b81a57d2e03f26b147eab98b))
* **python:** bump snakemake in /dependencies/python ([#5496](https://github.com/super-linter/super-linter/issues/5496)) ([794408d](https://github.com/super-linter/super-linter/commit/794408dfa40768211acdb12992bb8f244b6dd274))
* **python:** bump sqlfluff from 3.0.2 to 3.0.3 in /dependencies/python ([#5445](https://github.com/super-linter/super-linter/issues/5445)) ([c17fde6](https://github.com/super-linter/super-linter/commit/c17fde6fea2c3128ac1d0062e0817a3080c88a41))


### 🧰 Maintenance

* adding "permissions: { }" to the yaml example ([#5452](https://github.com/super-linter/super-linter/issues/5452)) ([64d808d](https://github.com/super-linter/super-linter/commit/64d808da2c1cba817d10a0f57801f5dc514bb020))
* do not run by pull request from fork ([#5506](https://github.com/super-linter/super-linter/issues/5506)) ([a1c890c](https://github.com/super-linter/super-linter/commit/a1c890c1f28ca160979f861f6be7dba22c3c8ace))
* fix a run condition in CI preview-release-notes ([#5532](https://github.com/super-linter/super-linter/issues/5532)) ([95fbd33](https://github.com/super-linter/super-linter/commit/95fbd33daf1b1a436cab61875ea5367952d0e51b))
* free more space on workers ([#5481](https://github.com/super-linter/super-linter/issues/5481)) ([80bb077](https://github.com/super-linter/super-linter/commit/80bb077cfd8a341424dbd60076b3a9e14518e9fb)), closes [#5477](https://github.com/super-linter/super-linter/issues/5477)
* ignore github_conf in jscpd ([#5533](https://github.com/super-linter/super-linter/issues/5533)) ([0873f46](https://github.com/super-linter/super-linter/commit/0873f467042e21fc956ac5f363fdf023755580f4))

## [6.3.1](https://github.com/super-linter/super-linter/compare/v6.3.0...v6.3.1) (2024-04-04)


### 🐛 Bugfixes

* do not print the whole environment ([#5473](https://github.com/super-linter/super-linter/issues/5473)) ([39edf76](https://github.com/super-linter/super-linter/commit/39edf76351164a520b3df903a47c7b06379ccf11))
* remove cpanm cache ([#5385](https://github.com/super-linter/super-linter/issues/5385)) ([b00466d](https://github.com/super-linter/super-linter/commit/b00466d6b14849f7bfb859022b6938494de2f685))
* revert eslint-config and enable strict checks ([#5423](https://github.com/super-linter/super-linter/issues/5423)) ([3e1c570](https://github.com/super-linter/super-linter/commit/3e1c570d32a733a5b82e493bf95fba76e4017694)), closes [#5422](https://github.com/super-linter/super-linter/issues/5422)


### ⬆️ Dependency updates

* **bundler:** bump rubocop from 1.60.2 to 1.61.0 in /dependencies ([#5359](https://github.com/super-linter/super-linter/issues/5359)) ([20da02a](https://github.com/super-linter/super-linter/commit/20da02ac5c82089b3973de737bdda323153b4d31))
* **bundler:** bump rubocop from 1.61.0 to 1.62.1 in /dependencies ([#5372](https://github.com/super-linter/super-linter/issues/5372)) ([22debee](https://github.com/super-linter/super-linter/commit/22debeed5fdbd7b898737d9c851b3960e8af66fe))
* **bundler:** bump rubocop-minitest in /dependencies ([#5371](https://github.com/super-linter/super-linter/issues/5371)) ([8974415](https://github.com/super-linter/super-linter/commit/897441590d803420d3cbbb0bd13549d99f3c7947))
* **bundler:** bump rubocop-rails from 2.23.1 to 2.24.0 in /dependencies ([#5358](https://github.com/super-linter/super-linter/issues/5358)) ([dceea3d](https://github.com/super-linter/super-linter/commit/dceea3dd60bb55d5e32fe85acef70705a3120a86))
* **bundler:** bump rubocop-rspec from 2.26.1 to 2.27.1 in /dependencies ([#5360](https://github.com/super-linter/super-linter/issues/5360)) ([630d44b](https://github.com/super-linter/super-linter/commit/630d44b158733bafd0c70eb297871dd0e7d9d89f))
* **bundler:** bump standard from 1.34.0 to 1.35.1 in /dependencies ([#5426](https://github.com/super-linter/super-linter/issues/5426)) ([69cc492](https://github.com/super-linter/super-linter/commit/69cc4921a28a97fe0bd2df787ff18a89ff81b3c9))
* **dev-docker:** bump node in /dev-dependencies ([#5390](https://github.com/super-linter/super-linter/issues/5390)) ([4650e8e](https://github.com/super-linter/super-linter/commit/4650e8e811927e5f0dbfeb8b1c43edabb3f763b5))
* **dev-npm:** bump @commitlint/cli in /dev-dependencies ([#5396](https://github.com/super-linter/super-linter/issues/5396)) ([b34674f](https://github.com/super-linter/super-linter/commit/b34674f20b4891ff43139773f7096cb88e515da8))
* **dev-npm:** bump @commitlint/config-conventional in /dev-dependencies ([#5395](https://github.com/super-linter/super-linter/issues/5395)) ([a79e071](https://github.com/super-linter/super-linter/commit/a79e0713081befa22a7e39b48aa8bc41c5519dc7))
* **dev-npm:** bump release-please in /dev-dependencies ([#5394](https://github.com/super-linter/super-linter/issues/5394)) ([10b5245](https://github.com/super-linter/super-linter/commit/10b5245d84a15e2d0b480889be737b393fe73906))
* **docker:** bump alpine/terragrunt from 1.7.4 to 1.7.5 ([#5389](https://github.com/super-linter/super-linter/issues/5389)) ([a72dd13](https://github.com/super-linter/super-linter/commit/a72dd13e76ca62bbd44ff7b6198b7e087bb81ec3))
* **docker:** bump clj-kondo/clj-kondo ([#5388](https://github.com/super-linter/super-linter/issues/5388)) ([81ab1ad](https://github.com/super-linter/super-linter/commit/81ab1ad60b2ec949177bf1a185f12f57dcc27786))
* **docker:** bump dart from 3.3.0-sdk to 3.3.1-sdk ([#5368](https://github.com/super-linter/super-linter/issues/5368)) ([d21db8d](https://github.com/super-linter/super-linter/commit/d21db8d843ddbf70634ca9d2eb78a23e4f80387a))
* **docker:** bump golang from 1.22.0-alpine to 1.22.1-alpine ([#5366](https://github.com/super-linter/super-linter/issues/5366)) ([63a458f](https://github.com/super-linter/super-linter/commit/63a458fa812b278b08b3c3f1616aeefa3d305812))
* **docker:** bump hashicorp/terraform from 1.7.4 to 1.7.5 ([#5387](https://github.com/super-linter/super-linter/issues/5387)) ([abfcf4e](https://github.com/super-linter/super-linter/commit/abfcf4e3d58537f512a8f974277327f8db2c0605))
* **docker:** bump koalaman/shellcheck from v0.9.0 to v0.10.0 ([#5365](https://github.com/super-linter/super-linter/issues/5365)) ([4f182d7](https://github.com/super-linter/super-linter/commit/4f182d764ef46059fb6d1182365098678f0eb9ba))
* **docker:** bump yoheimuta/protolint from 0.47.6 to 0.49.3 ([#5386](https://github.com/super-linter/super-linter/issues/5386)) ([5fcd592](https://github.com/super-linter/super-linter/commit/5fcd5927d44fb2aad575dd0cf3b54b5d50eac27e))
* **github-actions:** bump actions/download-artifact from 4.1.2 to 4.1.4 ([#5361](https://github.com/super-linter/super-linter/issues/5361)) ([af522a6](https://github.com/super-linter/super-linter/commit/af522a60bb37acabb27684dfc32e433b88187722))
* **github-actions:** bump akhilerm/tag-push-action from 2.1.0 to 2.2.0 ([#5392](https://github.com/super-linter/super-linter/issues/5392)) ([156d046](https://github.com/super-linter/super-linter/commit/156d0463d75b1e841b495701a3f56c63a351cbc8))
* **github-actions:** bump docker/login-action from 3.0.0 to 3.1.0 ([#5391](https://github.com/super-linter/super-linter/issues/5391)) ([9ad7a43](https://github.com/super-linter/super-linter/commit/9ad7a43a7d0556925b8b306d825e81a6f6b45a4c))
* **java:** bump com.google.googlejavaformat:google-java-format ([#5364](https://github.com/super-linter/super-linter/issues/5364)) ([cb595ba](https://github.com/super-linter/super-linter/commit/cb595bae8bb63fedb0f19558fef91cd3ee480cd7))
* **java:** bump com.pinterest.ktlint:ktlint-cli in /dependencies/ktlint ([#5354](https://github.com/super-linter/super-linter/issues/5354)) ([a40f1d8](https://github.com/super-linter/super-linter/commit/a40f1d828b3b200303994a13305eb0763e37d58b))
* **java:** bump com.puppycrawl.tools:checkstyle ([#5355](https://github.com/super-linter/super-linter/issues/5355)) ([25e8c22](https://github.com/super-linter/super-linter/commit/25e8c22379a6fc1aa8fd768b04731a2e351fdb56))
* **java:** bump com.puppycrawl.tools:checkstyle ([#5393](https://github.com/super-linter/super-linter/issues/5393)) ([93ba832](https://github.com/super-linter/super-linter/commit/93ba8329903b295130a588a636679575bde113f2))
* **npm:** bump @ibm/tekton-lint in /dependencies ([#5408](https://github.com/super-linter/super-linter/issues/5408)) ([a07571a](https://github.com/super-linter/super-linter/commit/a07571acb8fd707c92007a40c3b8b98be0d628e4))
* **npm:** bump @react-native/eslint-config in /dependencies ([#5417](https://github.com/super-linter/super-linter/issues/5417)) ([6e35bed](https://github.com/super-linter/super-linter/commit/6e35bed01240b6979036730db25219ea4d49e371))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5352](https://github.com/super-linter/super-linter/issues/5352)) ([4b99bb9](https://github.com/super-linter/super-linter/commit/4b99bb9d334c19fc1e46fdbdb4157dacc6920c2f))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5418](https://github.com/super-linter/super-linter/issues/5418)) ([c312285](https://github.com/super-linter/super-linter/commit/c3122858d6fd5e0d3baff7d3d37de9375590efd8))
* **npm:** bump eslint-plugin-jsonc in /dependencies ([#5420](https://github.com/super-linter/super-linter/issues/5420)) ([ed2d6a4](https://github.com/super-linter/super-linter/commit/ed2d6a4775ec76e327141683d447251453c06563))
* **npm:** bump eslint-plugin-react in /dependencies ([#5351](https://github.com/super-linter/super-linter/issues/5351)) ([b801d8d](https://github.com/super-linter/super-linter/commit/b801d8d3d15583bff964948af465c72ecc3982a0))
* **npm:** bump eslint-plugin-react in /dependencies ([#5406](https://github.com/super-linter/super-linter/issues/5406)) ([3ebbbf7](https://github.com/super-linter/super-linter/commit/3ebbbf74c49cb8450d06872a1c9140f4bcdc878d))
* **npm:** bump eslint-plugin-vue from 9.22.0 to 9.23.0 in /dependencies ([#5397](https://github.com/super-linter/super-linter/issues/5397)) ([41af8fc](https://github.com/super-linter/super-linter/commit/41af8fc21c97d8664ee6950f062a91cc15597450))
* **npm:** bump next from 14.1.0 to 14.1.1 in /dependencies ([#5353](https://github.com/super-linter/super-linter/issues/5353)) ([a5c0d35](https://github.com/super-linter/super-linter/commit/a5c0d35e57245c30181f05e62c4986aea78edf6a))
* **npm:** bump next from 14.1.1 to 14.1.3 in /dependencies ([#5377](https://github.com/super-linter/super-linter/issues/5377)) ([34bd610](https://github.com/super-linter/super-linter/commit/34bd610cf7fafcb55e6b1c4e81ee765d5bbe4525))
* **npm:** bump npm-groovy-lint from 14.2.2 to 14.2.3 in /dependencies ([#5346](https://github.com/super-linter/super-linter/issues/5346)) ([fa9b638](https://github.com/super-linter/super-linter/commit/fa9b6383da387c6ece86807b6c00725ff1444e22))
* **npm:** bump npm-groovy-lint from 14.2.3 to 14.2.4 in /dependencies ([#5410](https://github.com/super-linter/super-linter/issues/5410)) ([49efd84](https://github.com/super-linter/super-linter/commit/49efd848cf44a87039e68a57d5a58ec407977f5b))
* **npm:** bump react-router-dom from 6.22.1 to 6.22.2 in /dependencies ([#5349](https://github.com/super-linter/super-linter/issues/5349)) ([770c355](https://github.com/super-linter/super-linter/commit/770c355b6aa249d27063169cb1e858713a51b8c2))
* **npm:** bump react-router-dom from 6.22.2 to 6.22.3 in /dependencies ([#5373](https://github.com/super-linter/super-linter/issues/5373)) ([0e6d8ff](https://github.com/super-linter/super-linter/commit/0e6d8ff0acae47f2d268af8d9806faa7a13bcbf7))
* **npm:** bump renovate from 37.214.0 to 37.226.1 in /dependencies ([#5350](https://github.com/super-linter/super-linter/issues/5350)) ([d84ef4c](https://github.com/super-linter/super-linter/commit/d84ef4cac179551a1d854e225f351576f4ddd292))
* **npm:** bump renovate from 37.226.1 to 37.263.0 in /dependencies ([#5416](https://github.com/super-linter/super-linter/issues/5416)) ([3504f7c](https://github.com/super-linter/super-linter/commit/3504f7c31784e30aaf130adf875a78558c76d4ff))
* **npm:** bump textlint from 14.0.3 to 14.0.4 in /dependencies ([#5409](https://github.com/super-linter/super-linter/issues/5409)) ([dee0abf](https://github.com/super-linter/super-linter/commit/dee0abf34fcaa47fef21fcf5a2df41cc1417f92f))
* **npm:** bump typescript from 5.3.3 to 5.4.2 in /dependencies ([#5374](https://github.com/super-linter/super-linter/issues/5374)) ([aa3ca06](https://github.com/super-linter/super-linter/commit/aa3ca066f415c5cd5e91764ac9b697ddd348d3b9))
* **python:** bump ansible-lint in /dependencies/python ([#5402](https://github.com/super-linter/super-linter/issues/5402)) ([6e55e1a](https://github.com/super-linter/super-linter/commit/6e55e1ae30aeb14de549b8ac3a43a92830aa95c5))
* **python:** bump black from 24.2.0 to 24.3.0 in /dependencies/python ([#5405](https://github.com/super-linter/super-linter/issues/5405)) ([e410312](https://github.com/super-linter/super-linter/commit/e410312bdfbeec55180c88c443b91b7c57309bba))
* **python:** bump cfn-lint in /dependencies/python ([#5356](https://github.com/super-linter/super-linter/issues/5356)) ([421f6f4](https://github.com/super-linter/super-linter/commit/421f6f49db8013e6ea2c4bdb88fe5ed9ad54a159))
* **python:** bump cfn-lint in /dependencies/python ([#5379](https://github.com/super-linter/super-linter/issues/5379)) ([e7191df](https://github.com/super-linter/super-linter/commit/e7191df78f28bd2fa2d3fd4c8a099114e68ddea8))
* **python:** bump checkov from 3.2.26 to 3.2.30 in /dependencies/python ([#5357](https://github.com/super-linter/super-linter/issues/5357)) ([4843854](https://github.com/super-linter/super-linter/commit/4843854209030f414230f6d326309fd7ee2ad8db))
* **python:** bump checkov from 3.2.30 to 3.2.39 in /dependencies/python ([#5401](https://github.com/super-linter/super-linter/issues/5401)) ([148746f](https://github.com/super-linter/super-linter/commit/148746f01766799621e7fce4994009a183d47069))
* **python:** bump mypy from 1.8.0 to 1.9.0 in /dependencies/python ([#5380](https://github.com/super-linter/super-linter/issues/5380)) ([4b38d74](https://github.com/super-linter/super-linter/commit/4b38d74238a921616d7a1bdabee63e2ab8eb0588))
* **python:** bump snakemake from 8.5.3 to 8.9.0 in /dependencies/python ([#5425](https://github.com/super-linter/super-linter/issues/5425)) ([3ec9980](https://github.com/super-linter/super-linter/commit/3ec9980fe40da3fd163a8b039b08a135e8f511b0))
* **python:** bump sqlfluff from 2.3.5 to 3.0.2 in /dependencies/python ([#5404](https://github.com/super-linter/super-linter/issues/5404)) ([9211b37](https://github.com/super-linter/super-linter/commit/9211b377d08e4a4072086dff280f914455750d33))


### 🧰 Maintenance

* add glibc via gcompat layer ([#5334](https://github.com/super-linter/super-linter/issues/5334)) ([252a980](https://github.com/super-linter/super-linter/commit/252a98096191286de3794b2aba5f09593169a01c))
* **docker:** update psscript analyzer to 1.22.0 ([#5428](https://github.com/super-linter/super-linter/issues/5428)) ([6842e2d](https://github.com/super-linter/super-linter/commit/6842e2d3cc468d1b9c4523349e8eec808338539b))
* install zlib from alpine packages ([#5317](https://github.com/super-linter/super-linter/issues/5317)) ([1eea612](https://github.com/super-linter/super-linter/commit/1eea6127e151aaf9914ed716475d020a416447d6))

## [6.3.0](https://github.com/super-linter/super-linter/compare/v6.2.0...v6.3.0) (2024-02-28)


### 🚀 Features

* **bash-exec:** add option to ignore shell library files ([#5254](https://github.com/super-linter/super-linter/issues/5254)) ([95aabd4](https://github.com/super-linter/super-linter/commit/95aabd4cfad43f0760041a6840b2098a08117e7e))


### 🐛 Bugfixes

* don't immediately exit on errors ([#5336](https://github.com/super-linter/super-linter/issues/5336)) ([4a05d78](https://github.com/super-linter/super-linter/commit/4a05d78ed4b49bf1498547cac9beb5fa1dc496e7)), closes [#5335](https://github.com/super-linter/super-linter/issues/5335)
* fix log level variable assignment ([#5319](https://github.com/super-linter/super-linter/issues/5319)) ([52b082b](https://github.com/super-linter/super-linter/commit/52b082b1f63a5b83e3e4a833a903180b151061bd))
* simplify log infrastructure ([#5312](https://github.com/super-linter/super-linter/issues/5312)) ([0f91a56](https://github.com/super-linter/super-linter/commit/0f91a56f2180b245f2876612816410a5dc73bdf3))


### ⬆️ Dependency updates

* **docker:** bump alpine/terragrunt from 1.7.3 to 1.7.4 ([#5325](https://github.com/super-linter/super-linter/issues/5325)) ([a3046b3](https://github.com/super-linter/super-linter/commit/a3046b34e64efe25bfd02dbc729f52f0a3296f80))
* **docker:** bump hashicorp/terraform from 1.7.3 to 1.7.4 ([#5322](https://github.com/super-linter/super-linter/issues/5322)) ([495881b](https://github.com/super-linter/super-linter/commit/495881bd33d303738554c498c87eb021a5b36da9))
* **docker:** bump rhysd/actionlint from 1.6.26 to 1.6.27 ([#5324](https://github.com/super-linter/super-linter/issues/5324)) ([7a349ac](https://github.com/super-linter/super-linter/commit/7a349acb0d2a4ff20b48661e228ab2db1cf1a223))
* **docker:** bump scalameta/scalafmt from v3.7.17 to v3.8.0 ([#5323](https://github.com/super-linter/super-linter/issues/5323)) ([6c1f40c](https://github.com/super-linter/super-linter/commit/6c1f40c9031146346142102c3ecca4954671735e))
* **docker:** bump yoheimuta/protolint from 0.47.5 to 0.47.6 ([#5321](https://github.com/super-linter/super-linter/issues/5321)) ([413f827](https://github.com/super-linter/super-linter/commit/413f82782df5a21a533f93e8dbfee84bcdded39c))
* **java:** bump com.google.googlejavaformat:google-java-format ([#5333](https://github.com/super-linter/super-linter/issues/5333)) ([ed01d3b](https://github.com/super-linter/super-linter/commit/ed01d3b73251c5cc728433123e3dbbf12c0ed515))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5332](https://github.com/super-linter/super-linter/issues/5332)) ([ddecff2](https://github.com/super-linter/super-linter/commit/ddecff21e4a9c317481491f1ea74f922efc208bf))
* **npm:** bump eslint from 8.56.0 to 8.57.0 in /dependencies ([#5330](https://github.com/super-linter/super-linter/issues/5330)) ([d74f8ad](https://github.com/super-linter/super-linter/commit/d74f8ad4e560ba32319048763aafa2e461334554))
* **npm:** bump eslint-plugin-vue from 9.21.1 to 9.22.0 in /dependencies ([#5329](https://github.com/super-linter/super-linter/issues/5329)) ([8357165](https://github.com/super-linter/super-linter/commit/83571650547645738be0a466f2a22babd0ce6ca6))
* **npm:** bump renovate from 37.202.2 to 37.214.0 in /dependencies ([#5331](https://github.com/super-linter/super-linter/issues/5331)) ([1528923](https://github.com/super-linter/super-linter/commit/1528923692af6031c32a397a21ba8f8302a785f9))
* **python:** bump checkov from 3.2.22 to 3.2.26 in /dependencies/python ([#5327](https://github.com/super-linter/super-linter/issues/5327)) ([87bea22](https://github.com/super-linter/super-linter/commit/87bea22ef459674638798804ddfe76c377da6118))
* **python:** bump pylint from 3.0.3 to 3.1.0 in /dependencies/python ([#5326](https://github.com/super-linter/super-linter/issues/5326)) ([592a42c](https://github.com/super-linter/super-linter/commit/592a42cde9ed0d832f09c91817ea7c67b1deef3d))
* **python:** bump snakemake from 8.4.9 to 8.5.3 in /dependencies/python ([#5328](https://github.com/super-linter/super-linter/issues/5328)) ([b1dbf25](https://github.com/super-linter/super-linter/commit/b1dbf250f4bd50fc7fcd4b856e329e10988a1e7d))


### 🧰 Maintenance

* add docs updates to changelog ([4a05d78](https://github.com/super-linter/super-linter/commit/4a05d78ed4b49bf1498547cac9beb5fa1dc496e7))
* **docs:** fix README typo ([#5338](https://github.com/super-linter/super-linter/issues/5338)) ([b8ee158](https://github.com/super-linter/super-linter/commit/b8ee1589a9e9295344e972da3ced7dc89dd90783))
* suggest setting fetch-depth on ref errors ([#5316](https://github.com/super-linter/super-linter/issues/5316)) ([608bd50](https://github.com/super-linter/super-linter/commit/608bd502d89e2840c79cb5b7c22f52a1661871f4)), closes [#5315](https://github.com/super-linter/super-linter/issues/5315)

## [6.2.0](https://github.com/super-linter/super-linter/compare/v6.1.1...v6.2.0) (2024-02-20)


### 🚀 Features

* enable shell error checks ([#5126](https://github.com/super-linter/super-linter/issues/5126)) ([0967cd2](https://github.com/super-linter/super-linter/commit/0967cd29d05996536f60cbec69861076d4abf9d5))


### 🐛 Bugfixes

* github actions debug logging ([#5288](https://github.com/super-linter/super-linter/issues/5288)) ([ed27c01](https://github.com/super-linter/super-linter/commit/ed27c0146da39a239d38f1e8bf681c4123126246))


### ⬆️ Dependency updates

* **bundler:** bump rubocop and standard in /dependencies ([#5295](https://github.com/super-linter/super-linter/issues/5295)) ([bf5d4ce](https://github.com/super-linter/super-linter/commit/bf5d4ce423b2e91027428d7359ea3d0061718940))
* **dev-docker:** bump node in /dev-dependencies ([#5305](https://github.com/super-linter/super-linter/issues/5305)) ([ae888f2](https://github.com/super-linter/super-linter/commit/ae888f2a1b8871c41809c1127eb9f1ed488112b4))
* **dev-npm:** bump @commitlint/cli in /dev-dependencies ([#5281](https://github.com/super-linter/super-linter/issues/5281)) ([4b16625](https://github.com/super-linter/super-linter/commit/4b16625701c07ca40a9afcb1aa71f83e2e6e1846))
* **dev-npm:** bump @commitlint/config-conventional in /dev-dependencies ([#5286](https://github.com/super-linter/super-linter/issues/5286)) ([ce0669b](https://github.com/super-linter/super-linter/commit/ce0669bc16197cc5bbceccce422bcd341e2a2440))
* **dev-npm:** bump release-please in /dev-dependencies ([#5306](https://github.com/super-linter/super-linter/issues/5306)) ([161dd16](https://github.com/super-linter/super-linter/commit/161dd16ccc0c022c0ad468e266bbeff4531e3c51))
* **docker:** bump dart from 3.2.6-sdk to 3.3.0-sdk ([#5300](https://github.com/super-linter/super-linter/issues/5300)) ([ac14610](https://github.com/super-linter/super-linter/commit/ac14610d3f07d33533fea8e5e4d7d89f6d03714d))
* **docker:** bump golangci/golangci-lint from v1.56.1 to v1.56.2 ([#5299](https://github.com/super-linter/super-linter/issues/5299)) ([d900e66](https://github.com/super-linter/super-linter/commit/d900e66ee10c5dcd9c998fa902cbfd577688a6ee))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5277](https://github.com/super-linter/super-linter/issues/5277)) ([947c92a](https://github.com/super-linter/super-linter/commit/947c92a513a48655c16e4d1c8e66accdeeca88f4))
* **npm:** bump eslint-plugin-jest in /dependencies ([#5296](https://github.com/super-linter/super-linter/issues/5296)) ([019c6c4](https://github.com/super-linter/super-linter/commit/019c6c476f193eb78bc3feda7d657a00fda001c0))
* **npm:** bump npm-groovy-lint from 14.2.1 to 14.2.2 in /dependencies ([#5298](https://github.com/super-linter/super-linter/issues/5298)) ([fee3d1c](https://github.com/super-linter/super-linter/commit/fee3d1ce2014bd7426c2f10264e358b0445f81e8))
* **npm:** bump react-router-dom from 6.22.0 to 6.22.1 in /dependencies ([#5293](https://github.com/super-linter/super-linter/issues/5293)) ([d1edc02](https://github.com/super-linter/super-linter/commit/d1edc02872b9c120f98b0ff94a7641c7d8a745ac))
* **npm:** bump renovate from 37.186.1 to 37.198.3 in /dependencies ([#5297](https://github.com/super-linter/super-linter/issues/5297)) ([0c77b0f](https://github.com/super-linter/super-linter/commit/0c77b0f692fcdd7978bbeadb7645fcc5f03842a1))
* **npm:** bump renovate from 37.198.3 to 37.202.2 in /dependencies ([#5310](https://github.com/super-linter/super-linter/issues/5310)) ([079f676](https://github.com/super-linter/super-linter/commit/079f676511580ea5639a05f212d624827dc5c378))
* **npm:** bump textlint from 14.0.2 to 14.0.3 in /dependencies ([#5294](https://github.com/super-linter/super-linter/issues/5294)) ([4ca6971](https://github.com/super-linter/super-linter/commit/4ca6971130172b2e6e2cc1824def4947bc524f8b))
* **python:** bump cfn-lint in /dependencies/python ([#5304](https://github.com/super-linter/super-linter/issues/5304)) ([1bf0370](https://github.com/super-linter/super-linter/commit/1bf037079f333d059db9b05ca77c808a24a0e3e3))
* **python:** bump checkov from 3.2.20 to 3.2.22 in /dependencies/python ([#5301](https://github.com/super-linter/super-linter/issues/5301)) ([6574a81](https://github.com/super-linter/super-linter/commit/6574a8121254966696a9caccf1e203ca6097bf34))
* **python:** bump snakemake from 8.4.8 to 8.4.9 in /dependencies/python ([#5302](https://github.com/super-linter/super-linter/issues/5302)) ([2b9f7f4](https://github.com/super-linter/super-linter/commit/2b9f7f4fe0ef423789ea8eb39cf5692be9902eff))
* **python:** bump yamllint in /dependencies/python ([#5303](https://github.com/super-linter/super-linter/issues/5303)) ([1913c7c](https://github.com/super-linter/super-linter/commit/1913c7c093b98c9ca8e3f8e98b0e2b95e1bd8402))


### 🧰 Maintenance

* **docs:** fix typos in readme ([#5291](https://github.com/super-linter/super-linter/issues/5291)) ([d331078](https://github.com/super-linter/super-linter/commit/d33107802b1ecab6ffc4146ac2d5644c72a673e4))
* don't explicitly install ts eslint parser ([#5311](https://github.com/super-linter/super-linter/issues/5311)) ([f59a3bd](https://github.com/super-linter/super-linter/commit/f59a3bd7f27f24f3c678faa0948bbd70db4092e1))
* dynamically build the test matrix ([#5307](https://github.com/super-linter/super-linter/issues/5307)) ([0938895](https://github.com/super-linter/super-linter/commit/0938895582bec1b00f666616490cf54adc8e21a8))

## [6.1.1](https://github.com/super-linter/super-linter/compare/v6.1.0...v6.1.1) (2024-02-15)


### 🧰 Maintenance

* configure git user and email ([#5284](https://github.com/super-linter/super-linter/issues/5284)) ([5451412](https://github.com/super-linter/super-linter/commit/54514126f23ac0044fcecb97ef7ee38085ad5a38)), closes [#5283](https://github.com/super-linter/super-linter/issues/5283)

## [6.1.0](https://github.com/super-linter/super-linter/compare/v6.0.0...v6.1.0) (2024-02-13)


### 🚀 Features

* automatically set the default branch ([#5242](https://github.com/super-linter/super-linter/issues/5242)) ([fe6e29b](https://github.com/super-linter/super-linter/commit/fe6e29b68595815676874fe5db0b240c215f7d48))
* lint xsd files ([#5250](https://github.com/super-linter/super-linter/issues/5250)) ([a26db6d](https://github.com/super-linter/super-linter/commit/a26db6d34d51090d35ad15a57ce619afdec2e9eb)), closes [#5248](https://github.com/super-linter/super-linter/issues/5248)
* remove mypy cache ([#5210](https://github.com/super-linter/super-linter/issues/5210)) ([ef9449e](https://github.com/super-linter/super-linter/commit/ef9449e2b0369fcb124127ba0986c51982321f7a))
* show error output when info is disabled ([#5251](https://github.com/super-linter/super-linter/issues/5251)) ([091eaa7](https://github.com/super-linter/super-linter/commit/091eaa71e334a000b4b411531b06bd0bd24f12eb))


### 🐛 Bugfixes

* create mypy cache directory ([#5240](https://github.com/super-linter/super-linter/issues/5240)) ([38edbe5](https://github.com/super-linter/super-linter/commit/38edbe557a40199e2bbb2b014cc88455322ef224))
* don't add unnecessary empty lines ([#5221](https://github.com/super-linter/super-linter/issues/5221)) ([eded427](https://github.com/super-linter/super-linter/commit/eded42747b4512364eb30228b610b9c648aa0082))
* don't print empty lines with default logging ([#5238](https://github.com/super-linter/super-linter/issues/5238)) ([20ded71](https://github.com/super-linter/super-linter/commit/20ded7178b0b0084f04fec11e40943e69cefd6a1))
* initialize GitHub domain variable ([#5216](https://github.com/super-linter/super-linter/issues/5216)) ([6fd6830](https://github.com/super-linter/super-linter/commit/6fd6830fb4a277ab1eefd57b10e2d05fd978d929))
* initialize terrascan at runtime ([#5246](https://github.com/super-linter/super-linter/issues/5246)) ([5b5e54a](https://github.com/super-linter/super-linter/commit/5b5e54ad5ced66a1dff4260f8144c1a36b271a4b))
* rely on default pylint configuration ([#5252](https://github.com/super-linter/super-linter/issues/5252)) ([a0cf6b5](https://github.com/super-linter/super-linter/commit/a0cf6b5c25444c1c2f5c2deb9b128c5e7a15cedf))
* unset the log_level variable ([#5249](https://github.com/super-linter/super-linter/issues/5249)) ([83eca1d](https://github.com/super-linter/super-linter/commit/83eca1df43450dc9b7bf67830d27cc7c485d9613)), closes [#5217](https://github.com/super-linter/super-linter/issues/5217)
* write hint about fetch-depth ([#5241](https://github.com/super-linter/super-linter/issues/5241)) ([787b63d](https://github.com/super-linter/super-linter/commit/787b63ddb2b5a8632a7169cd6ad71dca4a6af8d2))


### ⬆️ Dependency updates

* **dev-docker:** bump node in /dev-dependencies ([#5230](https://github.com/super-linter/super-linter/issues/5230)) ([0b5a56d](https://github.com/super-linter/super-linter/commit/0b5a56dff83affc264886fe5252d6c67d977083a))
* **docker:** bump alpine/terragrunt from 1.7.1 to 1.7.2 ([#5234](https://github.com/super-linter/super-linter/issues/5234)) ([31c3195](https://github.com/super-linter/super-linter/commit/31c31958389e9cdf8aa81abb7f8c82885f0eccbc))
* **docker:** bump alpine/terragrunt from 1.7.2 to 1.7.3 ([#5275](https://github.com/super-linter/super-linter/issues/5275)) ([d4f6d04](https://github.com/super-linter/super-linter/commit/d4f6d04fe1e7572d0a4360cf94881e493aa7b955))
* **docker:** bump clj-kondo/clj-kondo ([#5260](https://github.com/super-linter/super-linter/issues/5260)) ([02e9da5](https://github.com/super-linter/super-linter/commit/02e9da59ae0baedd6410192b46e14418ab50357f))
* **docker:** bump dart from 3.2.5-sdk to 3.2.6-sdk ([#5233](https://github.com/super-linter/super-linter/issues/5233)) ([ee53371](https://github.com/super-linter/super-linter/commit/ee5337123fb1500f3512641e0e9f9a514da0f354))
* **docker:** bump golang from 1.21.6-alpine to 1.22.0-alpine ([#5274](https://github.com/super-linter/super-linter/issues/5274)) ([acc794f](https://github.com/super-linter/super-linter/commit/acc794fd565a157e02b5ec332b0516d4f64dc001))
* **docker:** bump golangci/golangci-lint from v1.55.2 to v1.56.1 ([#5256](https://github.com/super-linter/super-linter/issues/5256)) ([edd813a](https://github.com/super-linter/super-linter/commit/edd813ae5521d2a6f19089cf9f3f9df1fad13491))
* **docker:** bump hashicorp/terraform from 1.7.1 to 1.7.2 ([#5231](https://github.com/super-linter/super-linter/issues/5231)) ([27bb6ab](https://github.com/super-linter/super-linter/commit/27bb6abc569a490977a00a9243efaa530e9cca0f))
* **docker:** bump hashicorp/terraform from 1.7.2 to 1.7.3 ([#5273](https://github.com/super-linter/super-linter/issues/5273)) ([e4bcc5d](https://github.com/super-linter/super-linter/commit/e4bcc5d47dd81ecf9ddbf4ea3d557381590a76d0))
* **docker:** bump mvdan/shfmt from v3.7.0 to v3.8.0 ([#5257](https://github.com/super-linter/super-linter/issues/5257)) ([9b1e936](https://github.com/super-linter/super-linter/commit/9b1e9361ee7f1a1e0e495f0014cbf8b61bc26727))
* **docker:** bump powershell from 7.3-alpine-3.17 to 7.4-alpine-3.17 ([#5279](https://github.com/super-linter/super-linter/issues/5279)) ([3e6a272](https://github.com/super-linter/super-linter/commit/3e6a272033d933930f7dae58f7504e59c1a02dd5))
* **docker:** bump python from 3.12.1-alpine3.19 to 3.12.2-alpine3.19 ([#5259](https://github.com/super-linter/super-linter/issues/5259)) ([07e5032](https://github.com/super-linter/super-linter/commit/07e5032e39cd32bf662a5d48ca12a8688ab6e122))
* **docker:** bump terraform-linters/tflint from v0.50.2 to v0.50.3 ([#5258](https://github.com/super-linter/super-linter/issues/5258)) ([5dc9a6a](https://github.com/super-linter/super-linter/commit/5dc9a6a8fa6bc40e55feb412f9c61f1315c18898))
* **docker:** bump zricethezav/gitleaks from v8.18.1 to v8.18.2 ([#5232](https://github.com/super-linter/super-linter/issues/5232)) ([299dbf0](https://github.com/super-linter/super-linter/commit/299dbf00a2d0326bc5abf0685c7a80ddcbc0bce0))
* **npm:** bump @babel/eslint-parser in /dependencies ([#5226](https://github.com/super-linter/super-linter/issues/5226)) ([3b12f82](https://github.com/super-linter/super-linter/commit/3b12f82c30f442041c69ec7d12fa7a08e6b3f599))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5268](https://github.com/super-linter/super-linter/issues/5268)) ([e54b770](https://github.com/super-linter/super-linter/commit/e54b77095e45ce9e2277ed59343c855a6d77f6bf))
* **npm:** bump eslint-plugin-vue from 9.20.1 to 9.21.1 in /dependencies ([#5228](https://github.com/super-linter/super-linter/issues/5228)) ([7a2ac4f](https://github.com/super-linter/super-linter/commit/7a2ac4fa03c5718945e5f24b3d228369beafaa40))
* **npm:** bump npm-groovy-lint from 14.2.0 to 14.2.1 in /dependencies ([#5270](https://github.com/super-linter/super-linter/issues/5270)) ([53ab9a2](https://github.com/super-linter/super-linter/commit/53ab9a2b9ae61df779b6fb54ff20cf218323f77f))
* **npm:** bump prettier from 3.2.4 to 3.2.5 in /dependencies ([#5227](https://github.com/super-linter/super-linter/issues/5227)) ([bdc05b4](https://github.com/super-linter/super-linter/commit/bdc05b4eb3cb34e369c48f3b5afd902f4d5e150e))
* **npm:** bump react-router-dom from 6.21.3 to 6.22.0 in /dependencies ([#5225](https://github.com/super-linter/super-linter/issues/5225)) ([1bd6c0d](https://github.com/super-linter/super-linter/commit/1bd6c0d35df9b8a66e95788f2f43b7d67c936fe4))
* **npm:** bump renovate from 37.161.0 to 37.173.0 in /dependencies ([#5229](https://github.com/super-linter/super-linter/issues/5229)) ([5b10868](https://github.com/super-linter/super-linter/commit/5b108687703f9f6d1a3c1ff735e17d3719692483))
* **npm:** bump renovate from 37.173.0 to 37.183.2 in /dependencies ([#5266](https://github.com/super-linter/super-linter/issues/5266)) ([370d982](https://github.com/super-linter/super-linter/commit/370d9824115264beab90b2a5859e22154638b2c9))
* **npm:** bump renovate from 37.183.2 to 37.186.1 in /dependencies ([#5276](https://github.com/super-linter/super-linter/issues/5276)) ([4361db8](https://github.com/super-linter/super-linter/commit/4361db80ed850b72560c5532772e7f08506b183c))
* **npm:** bump textlint from 13.4.1 to 14.0.2 in /dependencies ([#5267](https://github.com/super-linter/super-linter/issues/5267)) ([f72605f](https://github.com/super-linter/super-linter/commit/f72605f03ada08540ef0881c72c3fc607f50095e))
* **python:** bump ansible-lint in /dependencies/python ([#5263](https://github.com/super-linter/super-linter/issues/5263)) ([e058597](https://github.com/super-linter/super-linter/commit/e058597f290322d21fb3dc2595c17f51fd6ee40f))
* **python:** bump black from 24.1.1 to 24.2.0 in /dependencies/python ([#5280](https://github.com/super-linter/super-linter/issues/5280)) ([11860a0](https://github.com/super-linter/super-linter/commit/11860a0d6027518b5f24142264cbe2f67ff06863))
* **python:** bump cfn-lint in /dependencies/python ([#5265](https://github.com/super-linter/super-linter/issues/5265)) ([09e6e2b](https://github.com/super-linter/super-linter/commit/09e6e2bbd6fcf993883332cc544071230ad2e298))
* **python:** bump checkov from 3.2.1 to 3.2.8 in /dependencies/python ([#5235](https://github.com/super-linter/super-linter/issues/5235)) ([5f511c3](https://github.com/super-linter/super-linter/commit/5f511c3a9d50ee761143ab665d546949d05eedab))
* **python:** bump checkov from 3.2.8 to 3.2.20 in /dependencies/python ([#5264](https://github.com/super-linter/super-linter/issues/5264)) ([b147157](https://github.com/super-linter/super-linter/commit/b147157b9e3366f9b14a6f7016f481fa509e5e80))
* **python:** bump snakefmt from 0.9.0 to 0.10.0 in /dependencies/python ([#5236](https://github.com/super-linter/super-linter/issues/5236)) ([924b193](https://github.com/super-linter/super-linter/commit/924b19397ae9daac3a2473a14367cbcedeb830e4))
* **python:** bump snakemake from 8.4.1 to 8.4.3 in /dependencies/python ([#5237](https://github.com/super-linter/super-linter/issues/5237)) ([b0183dc](https://github.com/super-linter/super-linter/commit/b0183dce186b180ef450698f65e8aa24501c8298))
* **python:** bump snakemake from 8.4.3 to 8.4.8 in /dependencies/python ([#5261](https://github.com/super-linter/super-linter/issues/5261)) ([fbd27fe](https://github.com/super-linter/super-linter/commit/fbd27feb8835e05869110490661b4c91b4ea62c1))
* **python:** bump yamllint in /dependencies/python ([#5262](https://github.com/super-linter/super-linter/issues/5262)) ([9b0427e](https://github.com/super-linter/super-linter/commit/9b0427ea6cbbe304fa53e46e7f53467febe398e3))


### 🧰 Maintenance

* clone the repository before tagging ([#5208](https://github.com/super-linter/super-linter/issues/5208)) ([5c67776](https://github.com/super-linter/super-linter/commit/5c67776f9d9d3065efda30d47aef21b332fa2173))
* fail on errors when installing chktex ([#5214](https://github.com/super-linter/super-linter/issues/5214)) ([92e9cb3](https://github.com/super-linter/super-linter/commit/92e9cb3c85af9f774355c7e7057e7760802695ca))
* install dotnet and powershell from images ([#5245](https://github.com/super-linter/super-linter/issues/5245)) ([49320c8](https://github.com/super-linter/super-linter/commit/49320c834ba153699196b8d45f27d61c6a819292)), closes [#5243](https://github.com/super-linter/super-linter/issues/5243)
* install lintr in a dedicated stage ([#5247](https://github.com/super-linter/super-linter/issues/5247)) ([1f2fbb1](https://github.com/super-linter/super-linter/commit/1f2fbb14cde98f44fb4c6913769e7a2726864a1e))
* move linter verions logic outside runtime ([#5197](https://github.com/super-linter/super-linter/issues/5197)) ([d7790e4](https://github.com/super-linter/super-linter/commit/d7790e4f1cba52debbceac83c5324cee61860cff))
* take package-lock into account in devcontainer ([#5278](https://github.com/super-linter/super-linter/issues/5278)) ([7a6ab11](https://github.com/super-linter/super-linter/commit/7a6ab115a6366deadb6b20223f3d331bb0d4da76))

## [6.0.0](https://github.com/super-linter/super-linter/compare/v5.7.2...v6.0.0) (2024-01-31)


### ⚠ BREAKING CHANGES

* deprecate error_on_missing_exec_bit ([#5120](https://github.com/super-linter/super-linter/issues/5120))
* uninstall eslint-config-airbnb-typescript ([#5077](https://github.com/super-linter/super-linter/issues/5077))
* validate configuration when using find ([#5045](https://github.com/super-linter/super-linter/issues/5045))
* run linters against the workspace ([#5041](https://github.com/super-linter/super-linter/issues/5041))
* exit on errors when running Git ([#4889](https://github.com/super-linter/super-linter/issues/4889))

### 🚀 Features

* add support for checkov to lint iac files ([#4925](https://github.com/super-linter/super-linter/issues/4925)) ([9d7268f](https://github.com/super-linter/super-linter/commit/9d7268fb99ac99a3d989ca3e3813698994981434))
* automatically handle ktlint updates ([#5049](https://github.com/super-linter/super-linter/issues/5049)) ([fa7cb56](https://github.com/super-linter/super-linter/commit/fa7cb563d801d0ffb1ba5c1410011ac0377dd3cf))
* delete temporary files and directories ([#5046](https://github.com/super-linter/super-linter/issues/5046)) ([3fb1c34](https://github.com/super-linter/super-linter/commit/3fb1c3467ceb660d507c27d14291e96655931e19))
* deprecate error_on_missing_exec_bit ([#5120](https://github.com/super-linter/super-linter/issues/5120)) ([3a56172](https://github.com/super-linter/super-linter/commit/3a5617235cee5b2620bc6145d8125f469c503599))
* don't check bake files with terragrunt ([#5178](https://github.com/super-linter/super-linter/issues/5178)) ([f1873b0](https://github.com/super-linter/super-linter/commit/f1873b03743df4874e109a1ab43fde06a5e72a84))
* don't inspect files if not needed ([#5094](https://github.com/super-linter/super-linter/issues/5094)) ([e62b382](https://github.com/super-linter/super-linter/commit/e62b382bf05c52f3a31f5bee8851490e25a83077))
* don't write colors and logs on disk if not necessary ([#4934](https://github.com/super-linter/super-linter/issues/4934)) ([879672e](https://github.com/super-linter/super-linter/commit/879672e9362a640c8d3ab377f714061da439b552))
* group log output on GitHub Actions ([#4961](https://github.com/super-linter/super-linter/issues/4961)) ([7150e1f](https://github.com/super-linter/super-linter/commit/7150e1f8b01db84faa42c68fdf483ff7b7f621ea))
* install .NET LTS instead of STS ([#5047](https://github.com/super-linter/super-linter/issues/5047)) ([5a175c2](https://github.com/super-linter/super-linter/commit/5a175c2e27814a6f609fa7783993701d970bce21))
* lint Go modules ([#4984](https://github.com/super-linter/super-linter/issues/4984)) ([3031780](https://github.com/super-linter/super-linter/commit/30317804b13180d8df0aea40d17f4304fdafec19))
* redact gitleaks secrets from output ([#5040](https://github.com/super-linter/super-linter/issues/5040)) ([61d0c69](https://github.com/super-linter/super-linter/commit/61d0c6992bbe6fb4430f88fe06557ad85c5ff602))
* run linters against the workspace ([#5041](https://github.com/super-linter/super-linter/issues/5041)) ([11b7010](https://github.com/super-linter/super-linter/commit/11b70102c3a30483b917d562942f115abeac03e0))
* run linters in parallel ([#5177](https://github.com/super-linter/super-linter/issues/5177)) ([99e41ce](https://github.com/super-linter/super-linter/commit/99e41ce451809888801dee7c9be8bbb5232c7dde))
* validate configuration when using find ([#5045](https://github.com/super-linter/super-linter/issues/5045)) ([69a45e0](https://github.com/super-linter/super-linter/commit/69a45e022ded513956b8538de464842cefab0abf))
* validate local git repo when ignoring files ([#4965](https://github.com/super-linter/super-linter/issues/4965)) ([ae70816](https://github.com/super-linter/super-linter/commit/ae7081660b76ad6324579c02c4e49417244a152f))
* validate variables and simplify lowercase ([#5128](https://github.com/super-linter/super-linter/issues/5128)) ([4a28fc5](https://github.com/super-linter/super-linter/commit/4a28fc5e734447db987ca7474fa7eb448c878504))


### 🐛 Bugfixes

* add missing checkov configuration file ([#5090](https://github.com/super-linter/super-linter/issues/5090)) ([901a901](https://github.com/super-linter/super-linter/commit/901a9016553e14f2017a886358a43dfc20b774bd))
* change directory when checking ignored files ([#4933](https://github.com/super-linter/super-linter/issues/4933)) ([eb688a0](https://github.com/super-linter/super-linter/commit/eb688a090cf7d2ee4f179a7caf18a996158fd989))
* don't forcefully validate Git repos if not needed ([#4953](https://github.com/super-linter/super-linter/issues/4953)) ([7a21f93](https://github.com/super-linter/super-linter/commit/7a21f934b424c138cdcbeb2c070932f71f8a184b))
* enable linting changed files with textlint ([#5100](https://github.com/super-linter/super-linter/issues/5100)) ([6f70ade](https://github.com/super-linter/super-linter/commit/6f70adee89784813aba031bccd86848e3b2a2588))
* exit on errors when running Git ([#4889](https://github.com/super-linter/super-linter/issues/4889)) ([5a8805d](https://github.com/super-linter/super-linter/commit/5a8805dc4fb3ff22315a0c7f8ce8d3cc7da81958))
* fail if r package installation fails ([#4994](https://github.com/super-linter/super-linter/issues/4994)) ([60983d3](https://github.com/super-linter/super-linter/commit/60983d395f841b06c42b8db4d29974e355c0df2c))
* fail when validating as expected ([#5076](https://github.com/super-linter/super-linter/issues/5076)) ([ededa44](https://github.com/super-linter/super-linter/commit/ededa44d363adc015264156d9c093aa6d5957ec4))
* fix file list when looking for changes ([#5044](https://github.com/super-linter/super-linter/issues/5044)) ([b214a59](https://github.com/super-linter/super-linter/commit/b214a59ca73c8e20811dbffe4055c612edbb62c2))
* fix GITHUB_BEFORE_SHA diff on push events ([#5096](https://github.com/super-linter/super-linter/issues/5096)) ([1d5ed2c](https://github.com/super-linter/super-linter/commit/1d5ed2c386837bf3cc11e180ca3756d6b6020b14))
* fix GITHUB_BEFORE_SHA initalization for push ([#5098](https://github.com/super-linter/super-linter/issues/5098)) ([cf2038d](https://github.com/super-linter/super-linter/commit/cf2038d90311f6d49b145d32a5c725bbfa2bfd33))
* handle log messages in CheckFileType ([#5117](https://github.com/super-linter/super-linter/issues/5117)) ([5a2056d](https://github.com/super-linter/super-linter/commit/5a2056d77a436e86528a4347ee25f88008a07d42))
* ignore changelog when running textlint ([#5204](https://github.com/super-linter/super-linter/issues/5204)) ([6015df2](https://github.com/super-linter/super-linter/commit/6015df21286bb39384b1c28c41c356da5b39a15a))
* simplify file status checks ([#5119](https://github.com/super-linter/super-linter/issues/5119)) ([3a784fc](https://github.com/super-linter/super-linter/commit/3a784fcfd611789d6e592bf1fd69866758340911))
* simplify multi status checks ([#4958](https://github.com/super-linter/super-linter/issues/4958)) ([e6e6e1f](https://github.com/super-linter/super-linter/commit/e6e6e1fa5f60e15d7e9b89248bb0809bea1c17e9))
* simplify worker and linterVersions ([#5123](https://github.com/super-linter/super-linter/issues/5123)) ([5219fee](https://github.com/super-linter/super-linter/commit/5219feefab13e3b62e848cccdc6801c0b84e768a))


### ⬆️ Dependency updates

* **bundler:** bump rubocop-minitest from 0.33.0 to 0.34.1 in /dependencies ([8af4c4e](https://github.com/super-linter/super-linter/commit/8af4c4ef2453252faef71ebac52f58997d67ac9b))
* **bundler:** bump rubocop-minitest in /dependencies ([#5067](https://github.com/super-linter/super-linter/issues/5067)) ([610a45e](https://github.com/super-linter/super-linter/commit/610a45e49fa6925abfafe4f9eee1a365f36f73f4))
* **bundler:** bump rubocop-minitest in /dependencies ([#5082](https://github.com/super-linter/super-linter/issues/5082)) ([c292b1a](https://github.com/super-linter/super-linter/commit/c292b1aaa1ec41e5070e4183406afef410011e8c))
* **bundler:** bump rubocop-minitest in /dependencies ([#5148](https://github.com/super-linter/super-linter/issues/5148)) ([dc220a9](https://github.com/super-linter/super-linter/commit/dc220a946049da29130d7ac2f97d039c6421b2de))
* **bundler:** bump rubocop-minitest in /dependencies ([#5155](https://github.com/super-linter/super-linter/issues/5155)) ([be31a75](https://github.com/super-linter/super-linter/commit/be31a75bad96d634a048658079bd27df22a1b1c3))
* **bundler:** bump rubocop-performance in /dependencies ([#5081](https://github.com/super-linter/super-linter/issues/5081)) ([cbbf484](https://github.com/super-linter/super-linter/commit/cbbf4843613e8c51803e35cb94d1a09936a98240))
* **bundler:** bump rubocop-performance in /dependencies ([#5108](https://github.com/super-linter/super-linter/issues/5108)) ([82cbf30](https://github.com/super-linter/super-linter/commit/82cbf30a631c96173a29c1bae3d39338eda51c5e))
* **bundler:** bump rubocop-rails from 2.22.2 to 2.23.0 in /dependencies ([277e5a3](https://github.com/super-linter/super-linter/commit/277e5a3b76b1412bd91c477c4ab3cdd5bafb3000))
* **bundler:** bump rubocop-rails from 2.23.0 to 2.23.1 in /dependencies ([#5066](https://github.com/super-linter/super-linter/issues/5066)) ([9ad35f5](https://github.com/super-linter/super-linter/commit/9ad35f58f420b2821c6006980ffc05e4e85992d3))
* **bundler:** bump rubocop-rspec from 2.25.0 to 2.26.1 in /dependencies ([#5106](https://github.com/super-linter/super-linter/issues/5106)) ([57b175a](https://github.com/super-linter/super-linter/commit/57b175a3fd26c7530e72c4c1e263fb642695cabf))
* **bundler:** bump standard and rubocop in /dependencies ([#5107](https://github.com/super-linter/super-linter/issues/5107)) ([efc2f05](https://github.com/super-linter/super-linter/commit/efc2f05e9b35d6cd7f865c9fcb7f492dca15dcf0))
* **bundler:** bump standard from 1.32.0 to 1.32.1 in /dependencies ([#4944](https://github.com/super-linter/super-linter/issues/4944)) ([24d4f2e](https://github.com/super-linter/super-linter/commit/24d4f2e9633e3dd4f768b231b10d175d3db27cc1))
* **dev-docker:** bump node in /dev-dependencies ([#5051](https://github.com/super-linter/super-linter/issues/5051)) ([ebeeae9](https://github.com/super-linter/super-linter/commit/ebeeae9e85f446b162bc7a70e9de35db8e8c2755))
* **dev-docker:** bump node in /dev-dependencies ([#5166](https://github.com/super-linter/super-linter/issues/5166)) ([effc52b](https://github.com/super-linter/super-linter/commit/effc52b03a6c29fc52b399b5ba60e9ce1112db81))
* **dev-npm:** bump @commitlint/cli in /dev-dependencies ([#5111](https://github.com/super-linter/super-linter/issues/5111)) ([3299cfc](https://github.com/super-linter/super-linter/commit/3299cfcddf3a0df5ccf687a0d6ea2b5cf67d4c71))
* **dev-npm:** bump @commitlint/cli in /dev-dependencies ([#5165](https://github.com/super-linter/super-linter/issues/5165)) ([8ff5c25](https://github.com/super-linter/super-linter/commit/8ff5c2509d56936714a78b2bb476c39516ce2c12))
* **dev-npm:** bump @commitlint/cli in /dev-dependencies ([#5192](https://github.com/super-linter/super-linter/issues/5192)) ([2f1bfef](https://github.com/super-linter/super-linter/commit/2f1bfef7f92b697cefc29d859010b770fedcee29))
* **dev-npm:** bump @commitlint/config-conventional in /dev-dependencies ([#5110](https://github.com/super-linter/super-linter/issues/5110)) ([4e34d3d](https://github.com/super-linter/super-linter/commit/4e34d3daf7bace025e5faa638b57fb5085eb368b))
* **dev-npm:** bump @commitlint/config-conventional in /dev-dependencies ([#5164](https://github.com/super-linter/super-linter/issues/5164)) ([fc3bca2](https://github.com/super-linter/super-linter/commit/fc3bca247fffd9cf2bf0203b383cabe5aa420934))
* **dev-npm:** bump @commitlint/config-conventional in /dev-dependencies ([#5194](https://github.com/super-linter/super-linter/issues/5194)) ([20914d3](https://github.com/super-linter/super-linter/commit/20914d30184a8404bd8510e8d166f0b7dae9f8e7))
* **dev-npm:** bump release-please in /dev-dependencies ([#5088](https://github.com/super-linter/super-linter/issues/5088)) ([4fca3cf](https://github.com/super-linter/super-linter/commit/4fca3cf28f47884f60a8eee7bacebfda2cb30ba7))
* **dev-npm:** bump release-please in /dev-dependencies ([#5112](https://github.com/super-linter/super-linter/issues/5112)) ([0a21656](https://github.com/super-linter/super-linter/commit/0a21656417d5d1b642fb60c218e119272d2460c6))
* **dev-npm:** bump release-please in /dev-dependencies ([#5193](https://github.com/super-linter/super-linter/issues/5193)) ([c9c1cd0](https://github.com/super-linter/super-linter/commit/c9c1cd00d4dab9725400a2e83f79d82a7578e965))
* **docker:** bump alpine from 3.18.4 to 3.18.5 ([#4942](https://github.com/super-linter/super-linter/issues/4942)) ([4645b76](https://github.com/super-linter/super-linter/commit/4645b7663a67d0ccc1aafdf2ebe670066f70d0c3))
* **docker:** bump alpine from 3.18.5 to 3.19.0 ([#4979](https://github.com/super-linter/super-linter/issues/4979)) ([b9d7d8d](https://github.com/super-linter/super-linter/commit/b9d7d8d9ab1981d12baa737605e43f52e1b501da))
* **docker:** bump alpine/terragrunt from 1.6.5 to 1.6.6 ([8cda5ef](https://github.com/super-linter/super-linter/commit/8cda5efa9cb2d79f3fc4f932366575c57067b8de))
* **docker:** bump alpine/terragrunt from 1.6.6 to 1.7.0 ([#5160](https://github.com/super-linter/super-linter/issues/5160)) ([6f1f9f3](https://github.com/super-linter/super-linter/commit/6f1f9f3adcbe97e6143d5fa9e4365347dbb921a3))
* **docker:** bump alpine/terragrunt from 1.7.0 to 1.7.1 ([#5182](https://github.com/super-linter/super-linter/issues/5182)) ([a1be603](https://github.com/super-linter/super-linter/commit/a1be60308a91aa53489220bc7e4d3f7b683b8ccc))
* **docker:** bump clj-kondo/clj-kondo ([#5069](https://github.com/super-linter/super-linter/issues/5069)) ([c208173](https://github.com/super-linter/super-linter/commit/c208173f2764d02b49c0cbf07b010bde663b5f01))
* **docker:** bump dart from 3.2.4-sdk to 3.2.5-sdk ([#5163](https://github.com/super-linter/super-linter/issues/5163)) ([ed014e5](https://github.com/super-linter/super-linter/commit/ed014e511ede8298f0432694fcce655e4f272c81))
* **docker:** bump golang from 1.21.4-alpine to 1.21.5-alpine ([#4978](https://github.com/super-linter/super-linter/issues/4978)) ([078f64a](https://github.com/super-linter/super-linter/commit/078f64a9655a56d9f7a809d3ac8ce45a115c3354))
* **docker:** bump golang from 1.21.5-alpine to 1.21.6-alpine ([#5137](https://github.com/super-linter/super-linter/issues/5137)) ([16b7c50](https://github.com/super-linter/super-linter/commit/16b7c50a0e16fe69b15d8612dae853a124d4c419))
* **docker:** bump hashicorp/terraform from 1.6.5 to 1.6.6 ([7803a7c](https://github.com/super-linter/super-linter/commit/7803a7c4f9f16f850abf04bd25c47c8c1e654db8))
* **docker:** bump hashicorp/terraform from 1.6.6 to 1.7.0 ([#5161](https://github.com/super-linter/super-linter/issues/5161)) ([f26b3de](https://github.com/super-linter/super-linter/commit/f26b3de8487739a1d13b1ad6078daaa10dbc2882))
* **docker:** bump hashicorp/terraform from 1.7.0 to 1.7.1 ([#5181](https://github.com/super-linter/super-linter/issues/5181)) ([91dab1e](https://github.com/super-linter/super-linter/commit/91dab1ed867af0f181aa49163385758d6e89e7cd))
* **docker:** bump tenable/terrascan from 1.18.4 to 1.18.5 ([#4943](https://github.com/super-linter/super-linter/issues/4943)) ([3a9513a](https://github.com/super-linter/super-linter/commit/3a9513a4ea86f214c8febdf6dad27be6ad93fc1b))
* **docker:** bump tenable/terrascan from 1.18.5 to 1.18.9 ([a574fdc](https://github.com/super-linter/super-linter/commit/a574fdc6344443d0d8198d8a0bfb7341f39b730d))
* **docker:** bump tenable/terrascan from 1.18.9 to 1.18.11 ([#5055](https://github.com/super-linter/super-linter/issues/5055)) ([88562ff](https://github.com/super-linter/super-linter/commit/88562ff546846c7762c3a68c91ce56bec2d1cfef))
* **docker:** bump terraform-linters/tflint from v0.48.0 to v0.49.0 ([96f9115](https://github.com/super-linter/super-linter/commit/96f9115f12d7c36af0315ad7e9690d579126d26c))
* **docker:** bump terraform-linters/tflint from v0.49.0 to v0.50.0 ([#5053](https://github.com/super-linter/super-linter/issues/5053)) ([dc166ec](https://github.com/super-linter/super-linter/commit/dc166ec78d65e2be5ec0be25ec89703dc16d4f71))
* **docker:** bump terraform-linters/tflint from v0.50.0 to v0.50.1 ([#5109](https://github.com/super-linter/super-linter/issues/5109)) ([f3431d7](https://github.com/super-linter/super-linter/commit/f3431d7d7cfe3b92998e68b6cb3bebde84b6d387))
* **docker:** bump terraform-linters/tflint from v0.50.1 to v0.50.2 ([#5162](https://github.com/super-linter/super-linter/issues/5162)) ([d1fcddc](https://github.com/super-linter/super-linter/commit/d1fcddcc101276503971e163eefffbec31d69766))
* **docker:** bump yoheimuta/protolint from 0.46.3 to 0.47.0 ([06fd2a9](https://github.com/super-linter/super-linter/commit/06fd2a9f45ff8602ec5d460075f3e5ffc7ab9993))
* **docker:** bump yoheimuta/protolint from 0.47.0 to 0.47.2 ([#5034](https://github.com/super-linter/super-linter/issues/5034)) ([17d5a62](https://github.com/super-linter/super-linter/commit/17d5a62cc09d8683cd85bcfc1c5dee7c1173939f))
* **docker:** bump yoheimuta/protolint from 0.47.2 to 0.47.3 ([#5052](https://github.com/super-linter/super-linter/issues/5052)) ([57218d3](https://github.com/super-linter/super-linter/commit/57218d3e19d7a20d546e0b94387af677909d5c73))
* **docker:** bump yoheimuta/protolint from 0.47.3 to 0.47.4 ([#5068](https://github.com/super-linter/super-linter/issues/5068)) ([0355c99](https://github.com/super-linter/super-linter/commit/0355c996e003f64e5a00b0157133ce6e4d4778d3))
* **docker:** bump yoheimuta/protolint from 0.47.4 to 0.47.5 ([#5138](https://github.com/super-linter/super-linter/issues/5138)) ([e0011b3](https://github.com/super-linter/super-linter/commit/e0011b38a0cab71578406a383a1f593b9f15b075))
* **docker:** switch to tflint image because tflint-bundle is deprecated ([#4990](https://github.com/super-linter/super-linter/issues/4990)) ([22564fb](https://github.com/super-linter/super-linter/commit/22564fb65c88fd48812290253a138a330d3aa03d))
* **github-actions:** bump actions/stale from 8 to 9 ([#4980](https://github.com/super-linter/super-linter/issues/4980)) ([fc0bde0](https://github.com/super-linter/super-linter/commit/fc0bde088f22ae4191437799333fbb066b24d77a))
* **github-actions:** bump github/codeql-action from 2 to 3 ([54d4ca1](https://github.com/super-linter/super-linter/commit/54d4ca17ed0899d5fd44acff7bbad44ad52ae466))
* **github-actions:** bump peter-evans/create-issue-from-file ([#5180](https://github.com/super-linter/super-linter/issues/5180)) ([a090a4c](https://github.com/super-linter/super-linter/commit/a090a4cf0e3a5181183d5a0b88ed06b46d7ac80d))
* **java:** bump com.google.googlejavaformat:google-java-format ([#5105](https://github.com/super-linter/super-linter/issues/5105)) ([09fa2cf](https://github.com/super-linter/super-linter/commit/09fa2cfb3e65f8cd5ed9240da0777b0090f9117b))
* **java:** bump com.google.googlejavaformat:google-java-format from 1.18.1 to 1.19.1 ([#5022](https://github.com/super-linter/super-linter/issues/5022)) ([3434940](https://github.com/super-linter/super-linter/commit/3434940f2cabd4980172cd40d298d470ea98842c))
* **java:** bump com.pinterest.ktlint:ktlint-cli in /dependencies/ktlint ([#5050](https://github.com/super-linter/super-linter/issues/5050)) ([20d12b4](https://github.com/super-linter/super-linter/commit/20d12b4c7aba7c1bda7a19becd5ee4e7429d8235))
* **java:** bump com.pinterest.ktlint:ktlint-cli in /dependencies/ktlint ([#5134](https://github.com/super-linter/super-linter/issues/5134)) ([996f6be](https://github.com/super-linter/super-linter/commit/996f6bed91488331d57683a6914e8cb26b0456ee))
* **java:** bump com.puppycrawl.tools:checkstyle ([#5087](https://github.com/super-linter/super-linter/issues/5087)) ([c831c95](https://github.com/super-linter/super-linter/commit/c831c956b99c0dfc3af442a2d7f128b9b79671af))
* **java:** bump com.puppycrawl.tools:checkstyle ([#5179](https://github.com/super-linter/super-linter/issues/5179)) ([e1b2a99](https://github.com/super-linter/super-linter/commit/e1b2a9927276cc688df7468deaa4319c73392250))
* **java:** bump com.puppycrawl.tools:checkstyle from 10.12.5 to 10.12.6 in /dependencies/checkstyle ([#4966](https://github.com/super-linter/super-linter/issues/4966)) ([037997a](https://github.com/super-linter/super-linter/commit/037997ac196f2b15cacc725251f7f57d8ebda41d))
* **npm:** bump @babel/eslint-parser in /dependencies ([#5195](https://github.com/super-linter/super-linter/issues/5195)) ([8fc3ca9](https://github.com/super-linter/super-linter/commit/8fc3ca9916ea7e26b8a27bbb3116ac201b10875c))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5153](https://github.com/super-linter/super-linter/issues/5153)) ([d8883f8](https://github.com/super-linter/super-linter/commit/d8883f879b5422cc5c805426b4d089c4f7cf8179))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5196](https://github.com/super-linter/super-linter/issues/5196)) ([0512c8e](https://github.com/super-linter/super-linter/commit/0512c8e3149911d32cee23a1827a087551630074))
* **npm:** bump @typescript-eslint/eslint-plugin in /dependencies ([#5202](https://github.com/super-linter/super-linter/issues/5202)) ([c0bcd1a](https://github.com/super-linter/super-linter/commit/c0bcd1a17d1900047e4f4c64790e2c1f75833b59))
* **npm:** bump @typescript-eslint/parser in /dependencies ([d8883f8](https://github.com/super-linter/super-linter/commit/d8883f879b5422cc5c805426b4d089c4f7cf8179))
* **npm:** bump @typescript-eslint/parser in /dependencies ([#5198](https://github.com/super-linter/super-linter/issues/5198)) ([72d8ac2](https://github.com/super-linter/super-linter/commit/72d8ac29c4c51c5db8ed65145c3c0e2bfe8c4d41))
* **npm:** bump eslint from 8.54.0 to 8.55.0 in /dependencies ([#4938](https://github.com/super-linter/super-linter/issues/4938)) ([169372c](https://github.com/super-linter/super-linter/commit/169372cb5e901799fac26add505a98f3d846bff8))
* **npm:** bump eslint from 8.55.0 to 8.56.0 in /dependencies ([dc139be](https://github.com/super-linter/super-linter/commit/dc139bef43c546d5537da851320e2b16701a4b16))
* **npm:** bump eslint-config-prettier from 9.0.0 to 9.1.0 in /dependencies ([#4937](https://github.com/super-linter/super-linter/issues/4937)) ([dc16e8a](https://github.com/super-linter/super-linter/commit/dc16e8a9549f2978d651c5b8f9d37c5c974eb1af))
* **npm:** bump eslint-plugin-jest in /dependencies ([#5103](https://github.com/super-linter/super-linter/issues/5103)) ([f15342c](https://github.com/super-linter/super-linter/commit/f15342c0cb9527bcdf54c612f97c553c202fa122))
* **npm:** bump eslint-plugin-jest in /dependencies ([#5143](https://github.com/super-linter/super-linter/issues/5143)) ([09171e0](https://github.com/super-linter/super-linter/commit/09171e009c5133157508c6c7c99d5cbcea180ef2))
* **npm:** bump eslint-plugin-jsonc from 2.10.0 to 2.11.1 in /dependencies ([63a1f05](https://github.com/super-linter/super-linter/commit/63a1f0520b835a8158bbec3d0975f49534b04600))
* **npm:** bump eslint-plugin-jsonc from 2.11.1 to 2.11.2 in /dependencies ([#5024](https://github.com/super-linter/super-linter/issues/5024)) ([a2cf180](https://github.com/super-linter/super-linter/commit/a2cf1807a74b6b332aa31b4385e090b1d40a4e81))
* **npm:** bump eslint-plugin-jsonc in /dependencies ([#5172](https://github.com/super-linter/super-linter/issues/5172)) ([4b9395f](https://github.com/super-linter/super-linter/commit/4b9395f3197a51fb165150b95813f5e1cc8ae486))
* **npm:** bump eslint-plugin-jsonc in /dependencies ([#5189](https://github.com/super-linter/super-linter/issues/5189)) ([a2610ba](https://github.com/super-linter/super-linter/commit/a2610ba98a6e91de4ac918e7f3c5692c850bc651))
* **npm:** bump eslint-plugin-prettier in /dependencies ([#5038](https://github.com/super-linter/super-linter/issues/5038)) ([579274a](https://github.com/super-linter/super-linter/commit/579274a6908955c1f0ca10a7e285b6a4da33c89a))
* **npm:** bump eslint-plugin-prettier in /dependencies ([#5058](https://github.com/super-linter/super-linter/issues/5058)) ([95a8130](https://github.com/super-linter/super-linter/commit/95a8130cf36a3768a9c4f2a54ba164344b555c63))
* **npm:** bump eslint-plugin-prettier in /dependencies ([#5136](https://github.com/super-linter/super-linter/issues/5136)) ([b0ab8ae](https://github.com/super-linter/super-linter/commit/b0ab8aed6c7b00ee15b0ef323b641b157c89e7bc))
* **npm:** bump eslint-plugin-vue from 9.19.1 to 9.19.2 in /dependencies ([#4939](https://github.com/super-linter/super-linter/issues/4939)) ([4103097](https://github.com/super-linter/super-linter/commit/4103097898730ddc815f213fcbadfd845abe3101))
* **npm:** bump eslint-plugin-vue from 9.19.2 to 9.20.1 in /dependencies ([#5135](https://github.com/super-linter/super-linter/issues/5135)) ([67bb2eb](https://github.com/super-linter/super-linter/commit/67bb2eb223c144c32a1b993857e12644c3317431))
* **npm:** bump gherkin-lint from 4.2.2 to 4.2.4 in /dependencies ([#5036](https://github.com/super-linter/super-linter/issues/5036)) ([7327ca7](https://github.com/super-linter/super-linter/commit/7327ca7c515e4ab71e4f2e475314fe135bf791ab))
* **npm:** bump markdownlint-cli from 0.37.0 to 0.38.0 in /dependencies ([#4971](https://github.com/super-linter/super-linter/issues/4971)) ([2c75d2c](https://github.com/super-linter/super-linter/commit/2c75d2cd6e7b40ecb0d27dc3ae5a96f58ea9e588))
* **npm:** bump markdownlint-cli from 0.38.0 to 0.39.0 in /dependencies ([#5191](https://github.com/super-linter/super-linter/issues/5191)) ([d0ec3f0](https://github.com/super-linter/super-linter/commit/d0ec3f0ddf029ff8f1ddd39426d5ee5162258ce6))
* **npm:** bump next from 14.0.3 to 14.0.4 in /dependencies ([#4973](https://github.com/super-linter/super-linter/issues/4973)) ([04b167f](https://github.com/super-linter/super-linter/commit/04b167fcb340eb611720749d844fa7518049e96f))
* **npm:** bump next from 14.0.4 to 14.1.0 in /dependencies ([#5167](https://github.com/super-linter/super-linter/issues/5167)) ([95172b7](https://github.com/super-linter/super-linter/commit/95172b73ac7bbbb9c48b015f950898c7d6c00292))
* **npm:** bump npm-groovy-lint from 13.0.2 to 14.0.0 in /dependencies ([8a983cf](https://github.com/super-linter/super-linter/commit/8a983cfc8aac9a7374f9e33c62241a50e13fe337))
* **npm:** bump npm-groovy-lint from 14.0.0 to 14.0.1 in /dependencies ([#5023](https://github.com/super-linter/super-linter/issues/5023)) ([f655d92](https://github.com/super-linter/super-linter/commit/f655d9222f1ff350eaeec4d6d50521a1af43f858))
* **npm:** bump npm-groovy-lint from 14.0.1 to 14.2.0 in /dependencies ([#5169](https://github.com/super-linter/super-linter/issues/5169)) ([63c394b](https://github.com/super-linter/super-linter/commit/63c394bc4d96aa2844c044bd3c6bcfbc9c1a3cdb))
* **npm:** bump prettier from 3.1.0 to 3.1.1 in /dependencies ([#4976](https://github.com/super-linter/super-linter/issues/4976)) ([92824c7](https://github.com/super-linter/super-linter/commit/92824c744ce9f340b9b8462ce6b29da4b012de74))
* **npm:** bump prettier from 3.1.1 to 3.2.2 in /dependencies ([#5147](https://github.com/super-linter/super-linter/issues/5147)) ([a0f5a76](https://github.com/super-linter/super-linter/commit/a0f5a76ebceb9ce01e5715c919d78342771bfb05))
* **npm:** bump prettier from 3.2.2 to 3.2.4 in /dependencies ([#5171](https://github.com/super-linter/super-linter/issues/5171)) ([d91e7a7](https://github.com/super-linter/super-linter/commit/d91e7a79f9b42f01a70a9460fd6090577813d661))
* **npm:** bump react-intl from 6.5.5 to 6.6.1 in /dependencies ([#5170](https://github.com/super-linter/super-linter/issues/5170)) ([2963da6](https://github.com/super-linter/super-linter/commit/2963da661143e47849e42beed980079dd9a48fe9))
* **npm:** bump react-intl from 6.6.1 to 6.6.2 in /dependencies ([#5183](https://github.com/super-linter/super-linter/issues/5183)) ([166d093](https://github.com/super-linter/super-linter/commit/166d093eab9298621d4d35fee282b3b5c610c930))
* **npm:** bump react-redux from 8.1.3 to 9.0.1 in /dependencies ([#4945](https://github.com/super-linter/super-linter/issues/4945)) ([c841237](https://github.com/super-linter/super-linter/commit/c841237f6af40df0ee00b8e8b44ec9fb3a477b43))
* **npm:** bump react-redux from 9.0.1 to 9.0.3 in /dependencies ([#4974](https://github.com/super-linter/super-linter/issues/4974)) ([0781e9d](https://github.com/super-linter/super-linter/commit/0781e9df9aff96db283847f52016b96a0e75d1cb))
* **npm:** bump react-redux from 9.0.3 to 9.0.4 in /dependencies ([1121c36](https://github.com/super-linter/super-linter/commit/1121c36aff73519e5ea00d0a8430ed9ee8c7c40b))
* **npm:** bump react-redux from 9.0.4 to 9.1.0 in /dependencies ([#5141](https://github.com/super-linter/super-linter/issues/5141)) ([3765c2d](https://github.com/super-linter/super-linter/commit/3765c2d619c6288954bb5ab162a16330f7bdeac9))
* **npm:** bump react-router-dom from 6.20.0 to 6.20.1 in /dependencies ([2ac4d45](https://github.com/super-linter/super-linter/commit/2ac4d451236870144f94b6acfff0833a7cb27dd3))
* **npm:** bump react-router-dom from 6.20.1 to 6.21.0 in /dependencies ([59d7347](https://github.com/super-linter/super-linter/commit/59d73472ae3fca18bba603bee7c65e9bdd94915e))
* **npm:** bump react-router-dom from 6.21.0 to 6.21.1 in /dependencies ([#5062](https://github.com/super-linter/super-linter/issues/5062)) ([3ed561c](https://github.com/super-linter/super-linter/commit/3ed561c0c5f0e2d003bf348d7f942dc79fdf3854))
* **npm:** bump react-router-dom from 6.21.1 to 6.21.2 in /dependencies ([#5139](https://github.com/super-linter/super-linter/issues/5139)) ([915e018](https://github.com/super-linter/super-linter/commit/915e018216aafbc3e992af35acde4a3238a1ebe0))
* **npm:** bump react-router-dom from 6.21.2 to 6.21.3 in /dependencies ([#5168](https://github.com/super-linter/super-linter/issues/5168)) ([c42e613](https://github.com/super-linter/super-linter/commit/c42e613b060568d1e36211a8856baa835f749113))
* **npm:** bump renovate from 37.102.0 to 37.105.0 in /dependencies ([#5037](https://github.com/super-linter/super-linter/issues/5037)) ([1299982](https://github.com/super-linter/super-linter/commit/12999828956de6005b59cdbd9f6fba95ba5489b8))
* **npm:** bump renovate from 37.105.0 to 37.107.0 in /dependencies ([#5061](https://github.com/super-linter/super-linter/issues/5061)) ([df6543f](https://github.com/super-linter/super-linter/commit/df6543f7636b91b7b2a32f5b6008187375b32ff5))
* **npm:** bump renovate from 37.107.0 to 37.115.0 in /dependencies ([#5085](https://github.com/super-linter/super-linter/issues/5085)) ([542f57e](https://github.com/super-linter/super-linter/commit/542f57e2cfef07f2eade31b62b309f58df62cacd))
* **npm:** bump renovate from 37.115.0 to 37.128.3 in /dependencies ([#5125](https://github.com/super-linter/super-linter/issues/5125)) ([fa2d870](https://github.com/super-linter/super-linter/commit/fa2d870b803ba2ffc3e4a03c3fa4374507827639))
* **npm:** bump renovate from 37.128.3 to 37.133.1 in /dependencies ([#5150](https://github.com/super-linter/super-linter/issues/5150)) ([b254bbb](https://github.com/super-linter/super-linter/commit/b254bbb354dd58f983d1f2846891297e032b726a))
* **npm:** bump renovate from 37.133.1 to 37.146.0 in /dependencies ([#5175](https://github.com/super-linter/super-linter/issues/5175)) ([9991465](https://github.com/super-linter/super-linter/commit/99914658e255bce7a0105a819a0fd2577a6df093))
* **npm:** bump renovate from 37.146.0 to 37.156.4 in /dependencies ([#5188](https://github.com/super-linter/super-linter/issues/5188)) ([3c4013f](https://github.com/super-linter/super-linter/commit/3c4013fff8d3ff41d56d65f303af65af8134e24e))
* **npm:** bump renovate from 37.156.4 to 37.161.0 in /dependencies ([#5203](https://github.com/super-linter/super-linter/issues/5203)) ([0578ab8](https://github.com/super-linter/super-linter/commit/0578ab8dafce2b7755dea69d5707990062806476))
* **npm:** bump renovate from 37.76.1 to 37.83.5 in /dependencies ([#4946](https://github.com/super-linter/super-linter/issues/4946)) ([7c606ee](https://github.com/super-linter/super-linter/commit/7c606eeb75f151dfbf8a42f84ac1358a59af1657))
* **npm:** bump renovate from 37.83.5 to 37.89.7 in /dependencies ([#4975](https://github.com/super-linter/super-linter/issues/4975)) ([e08664e](https://github.com/super-linter/super-linter/commit/e08664e03d8a39f166989787d37df56a01ec069d))
* **npm:** bump renovate from 37.89.7 to 37.102.0 in /dependencies ([8502410](https://github.com/super-linter/super-linter/commit/8502410fe90eb2e39bb37b770e9d76bdf9331f9c))
* **npm:** bump stylelint-scss from 5.3.1 to 5.3.2 in /dependencies ([#4977](https://github.com/super-linter/super-linter/issues/4977)) ([75231fe](https://github.com/super-linter/super-linter/commit/75231fe7719371122696b0ff224303587228c279))
* **npm:** bump typescript from 5.3.2 to 5.3.3 in /dependencies ([#4972](https://github.com/super-linter/super-linter/issues/4972)) ([866e67e](https://github.com/super-linter/super-linter/commit/866e67ec417a8700b9f3f2e1b25bfe0552e268cc))
* **php:** bump PHPCS, PHPStan, Psalm ([#4960](https://github.com/super-linter/super-linter/issues/4960)) ([304ca18](https://github.com/super-linter/super-linter/commit/304ca185da59cc0c860a746395294730d17770e5))
* **python:** bump ansible-lint in /dependencies/python ([#5159](https://github.com/super-linter/super-linter/issues/5159)) ([2a67be9](https://github.com/super-linter/super-linter/commit/2a67be9a07ff5a51a1be956094031d49f9bc2e42))
* **python:** bump black from 23.11.0 to 23.12.0 in /dependencies/python ([48bca12](https://github.com/super-linter/super-linter/commit/48bca128a1f8352fd4edd181bc1103a1952044b8))
* **python:** bump black from 23.12.0 to 23.12.1 in /dependencies/python ([#5056](https://github.com/super-linter/super-linter/issues/5056)) ([e705fb1](https://github.com/super-linter/super-linter/commit/e705fb156ee5076f069f903d339ad04354bda9e8))
* **python:** bump black from 23.12.1 to 24.1.1 in /dependencies/python ([#5187](https://github.com/super-linter/super-linter/issues/5187)) ([b95d812](https://github.com/super-linter/super-linter/commit/b95d812ee6623e01454065c49d3ecbdbfed96978))
* **python:** bump cfn-lint from 0.83.3 to 0.83.4 in /dependencies/python ([#4969](https://github.com/super-linter/super-linter/issues/4969)) ([b59f552](https://github.com/super-linter/super-linter/commit/b59f55295e4a05787ddf0ed57845f91d8d8579e6))
* **python:** bump cfn-lint from 0.83.4 to 0.83.6 in /dependencies/python ([7b4b464](https://github.com/super-linter/super-linter/commit/7b4b4642b49898bb2b0133f37b706d24daf9176d))
* **python:** bump cfn-lint in /dependencies/python ([#5059](https://github.com/super-linter/super-linter/issues/5059)) ([3f8eafd](https://github.com/super-linter/super-linter/commit/3f8eafdc04dee0ddcd426f4fa6868cd67c9db5d4))
* **python:** bump cfn-lint in /dependencies/python ([#5146](https://github.com/super-linter/super-linter/issues/5146)) ([4f008fc](https://github.com/super-linter/super-linter/commit/4f008fc34e205d33ce1b08afa998f1620d558444))
* **python:** bump cfn-lint in /dependencies/python ([#5156](https://github.com/super-linter/super-linter/issues/5156)) ([97018e5](https://github.com/super-linter/super-linter/commit/97018e5c2959ad9980cce374c68b96e18d8d4946))
* **python:** bump cfn-lint in /dependencies/python ([#5184](https://github.com/super-linter/super-linter/issues/5184)) ([24624f3](https://github.com/super-linter/super-linter/commit/24624f3f5ef7a811446b32ceab3fef831279f350))
* **python:** bump checkov from 3.1.38 to 3.1.43 in /dependencies/python ([#5054](https://github.com/super-linter/super-linter/issues/5054)) ([125c610](https://github.com/super-linter/super-linter/commit/125c610d00832554ee6bdc41df5b474d67218db3))
* **python:** bump checkov from 3.1.43 to 3.1.50 in /dependencies/python ([#5083](https://github.com/super-linter/super-linter/issues/5083)) ([67037d7](https://github.com/super-linter/super-linter/commit/67037d760febf327856b1440f05f046f654faf63))
* **python:** bump checkov from 3.1.50 to 3.1.55 in /dependencies/python ([#5113](https://github.com/super-linter/super-linter/issues/5113)) ([2068ecb](https://github.com/super-linter/super-linter/commit/2068ecb82d7ae7cdfc141a2df75bcfea13d98a6a))
* **python:** bump checkov from 3.1.55 to 3.1.61 in /dependencies/python ([#5151](https://github.com/super-linter/super-linter/issues/5151)) ([6f2ae58](https://github.com/super-linter/super-linter/commit/6f2ae58c303abc77e7075d34d2f38d3346817c12))
* **python:** bump checkov from 3.1.61 to 3.1.68 in /dependencies/python ([#5157](https://github.com/super-linter/super-linter/issues/5157)) ([495df21](https://github.com/super-linter/super-linter/commit/495df21b04eac3a1691a5b5497449463b267da0b))
* **python:** bump checkov from 3.1.68 to 3.2.0 in /dependencies/python ([#5186](https://github.com/super-linter/super-linter/issues/5186)) ([ac63664](https://github.com/super-linter/super-linter/commit/ac63664cb9a289fcc83e89846417cce00510f88f))
* **python:** bump checkov from 3.2.0 to 3.2.1 in /dependencies/python ([#5201](https://github.com/super-linter/super-linter/issues/5201)) ([f9719bc](https://github.com/super-linter/super-linter/commit/f9719bc5675ecb7a06a55594f2223287e549df8e))
* **python:** bump flake8 from 6.0.0 to 7.0.0 in /dependencies/python ([#5114](https://github.com/super-linter/super-linter/issues/5114)) ([2912e51](https://github.com/super-linter/super-linter/commit/2912e51d5ae80d62f07fad103f2890a8cd56e0ff))
* **python:** bump isort from 5.12.0 to 5.13.0 in /dependencies/python ([#4967](https://github.com/super-linter/super-linter/issues/4967)) ([e0724be](https://github.com/super-linter/super-linter/commit/e0724be6c62f0826a138a6773a3d9f75a86ea742))
* **python:** bump isort from 5.13.0 to 5.13.2 in /dependencies/python ([00cb9a7](https://github.com/super-linter/super-linter/commit/00cb9a77d859d96d8593b5b4fbd592b1fe33ed67))
* **python:** bump mypy from 1.7.1 to 1.8.0 in /dependencies/python ([#5060](https://github.com/super-linter/super-linter/issues/5060)) ([e127bdf](https://github.com/super-linter/super-linter/commit/e127bdfd5bbb64704d62ab8d240bd370b76440ca))
* **python:** bump npm-groovy-lint from 13.0.0 to 13.0.2 in /dependencies ([#4970](https://github.com/super-linter/super-linter/issues/4970)) ([b09ada1](https://github.com/super-linter/super-linter/commit/b09ada143f6cf129f6a56e722a354a79f0f5291b))
* **python:** bump pylint from 3.0.2 to 3.0.3 in /dependencies/python ([#4968](https://github.com/super-linter/super-linter/issues/4968)) ([3baf33a](https://github.com/super-linter/super-linter/commit/3baf33a40510f2f12ca4bf1f5cb2c77981874868))
* **python:** bump snakefmt from 0.8.5 to 0.9.0 in /dependencies/python ([#5142](https://github.com/super-linter/super-linter/issues/5142)) ([507f148](https://github.com/super-linter/super-linter/commit/507f148ede865f93842a050bc3a0168e5b80bc30))
* **python:** bump snakemake from 8.0.1 to 8.1.0 in /dependencies/python ([#5115](https://github.com/super-linter/super-linter/issues/5115)) ([e42ee78](https://github.com/super-linter/super-linter/commit/e42ee7868d447263041f0b234e4a526f2df45d18))
* **python:** bump snakemake from 8.1.0 to 8.1.3 in /dependencies/python ([#5145](https://github.com/super-linter/super-linter/issues/5145)) ([83916ea](https://github.com/super-linter/super-linter/commit/83916eae6da2a27bc161d488493294ec822a467d))
* **python:** bump snakemake from 8.1.3 to 8.2.3 in /dependencies/python ([#5158](https://github.com/super-linter/super-linter/issues/5158)) ([5fb1953](https://github.com/super-linter/super-linter/commit/5fb1953e558757a35cd3427405832eacedd1145a))
* **python:** bump snakemake from 8.2.3 to 8.4.0 in /dependencies/python ([#5185](https://github.com/super-linter/super-linter/issues/5185)) ([1079b8a](https://github.com/super-linter/super-linter/commit/1079b8ac6c195ed64a8da186c7187030dae11804))
* **python:** bump snakemake from 8.4.0 to 8.4.1 in /dependencies/python ([#5200](https://github.com/super-linter/super-linter/issues/5200)) ([94d2876](https://github.com/super-linter/super-linter/commit/94d28767db633628b4931d142f69cdd475b217ec))
* **python:** bump snakemake in /dependencies/python ([#5057](https://github.com/super-linter/super-linter/issues/5057)) ([dffec93](https://github.com/super-linter/super-linter/commit/dffec934fc2baaa328bcae56508befeda815d35b))


### 🧰 Maintenance

* add event name to concurrency group ([#5097](https://github.com/super-linter/super-linter/issues/5097)) ([f6bc054](https://github.com/super-linter/super-linter/commit/f6bc05453b52ede508329338bbfe785bd5d91913))
* cache more standard image layers ([#5133](https://github.com/super-linter/super-linter/issues/5133)) ([bf832c6](https://github.com/super-linter/super-linter/commit/bf832c60ae1960aae7d4b4c0bda05474a26527b4))
* configure commitlint ([#5014](https://github.com/super-linter/super-linter/issues/5014)) ([9db632f](https://github.com/super-linter/super-linter/commit/9db632f0e18a73a9845c11d0f35431e714a66772))
* configure release-please ([#5016](https://github.com/super-linter/super-linter/issues/5016)) ([93b5ede](https://github.com/super-linter/super-linter/commit/93b5ede1e83c88e6b3553affa520ad4f5a70e623))
* configure release-please dry-run and changelog ([#5039](https://github.com/super-linter/super-linter/issues/5039)) ([641c65a](https://github.com/super-linter/super-linter/commit/641c65a8c49feb1c7f580051a61226afc64be7a1))
* don't update the deployment if we didn't start it ([#4995](https://github.com/super-linter/super-linter/issues/4995)) ([2d303aa](https://github.com/super-linter/super-linter/commit/2d303aab53b2cc955ee580d031c1fbbaeee65b63))
* don't validate dependabot commits ([#5026](https://github.com/super-linter/super-linter/issues/5026)) ([117318f](https://github.com/super-linter/super-linter/commit/117318f55c86fe9d1f478c9d484f864af1e7ef0c))
* enable auto-merge for dependabot pull requests ([#5063](https://github.com/super-linter/super-linter/issues/5063)) ([59154bf](https://github.com/super-linter/super-linter/commit/59154bf97f8cee4ab4b0d64afca83e41355b9924))
* fix build cache in the cd workflow ([#5032](https://github.com/super-linter/super-linter/issues/5032)) ([43dc368](https://github.com/super-linter/super-linter/commit/43dc36860cfda82322c882574cddafed1236ff67))
* fix concurrency group name ([#5121](https://github.com/super-linter/super-linter/issues/5121)) ([2d79d17](https://github.com/super-linter/super-linter/commit/2d79d17e6e44bd859414b74282024773d0a06787))
* fix release workflow ([#5030](https://github.com/super-linter/super-linter/issues/5030)) ([9c70468](https://github.com/super-linter/super-linter/commit/9c7046864fc05a0d249d4a3dd928775cb5b55307))
* ignore changelog and tests when testing action ([#5206](https://github.com/super-linter/super-linter/issues/5206)) ([bcbc45a](https://github.com/super-linter/super-linter/commit/bcbc45aa63cd0f58282b41fbb68eeedeb005eac0))
* ignore changelog when linting codebase ([#5205](https://github.com/super-linter/super-linter/issues/5205)) ([ace79ca](https://github.com/super-linter/super-linter/commit/ace79ca4032a39ccd1cc6055e200eb54d982d7b0))
* implement more smoke tests ([#4955](https://github.com/super-linter/super-linter/issues/4955)) ([3a21ed5](https://github.com/super-linter/super-linter/commit/3a21ed5bdf17ad44a51cb279b790aca28046e2c8))
* install chktex ([#5074](https://github.com/super-linter/super-linter/issues/5074)) ([690d422](https://github.com/super-linter/super-linter/commit/690d422fd63cbc157177def7c5ecfa8bae472e4b))
* install clang-format from OS package repo ([#5071](https://github.com/super-linter/super-linter/issues/5071)) ([19e39e2](https://github.com/super-linter/super-linter/commit/19e39e211efc0870b17f6d3742fad69a777eed06))
* install clj-kondo from its container image ([#5064](https://github.com/super-linter/super-linter/issues/5064)) ([1dc74e1](https://github.com/super-linter/super-linter/commit/1dc74e194e375b77875e8d58f9e96178043cddd0))
* move instructions from the wiki to docs ([#4957](https://github.com/super-linter/super-linter/issues/4957)) ([2c54862](https://github.com/super-linter/super-linter/commit/2c548620af0799a5b7c7661339104bdc87f6fd2e))
* move tests to the test directory ([#4985](https://github.com/super-linter/super-linter/issues/4985)) ([e6cf8d3](https://github.com/super-linter/super-linter/commit/e6cf8d3845825a0e318e9ceab185e726f5ee5703))
* populate the cache with the latest image ([#4988](https://github.com/super-linter/super-linter/issues/4988)) ([e73e1bf](https://github.com/super-linter/super-linter/commit/e73e1bfdc3a78bd831911ae31921257103cd1fdc))
* python venvs and npm in dedicated stages ([#5078](https://github.com/super-linter/super-linter/issues/5078)) ([df91117](https://github.com/super-linter/super-linter/commit/df911171c4edf0a1937552e3b3b10858e11f2121))
* reduce container image size ([#5072](https://github.com/super-linter/super-linter/issues/5072)) ([1ca3ebc](https://github.com/super-linter/super-linter/commit/1ca3ebccd6b63a0d880c6b7603ff2dddb6f37ac4))
* reduce duplication in CI and CD workflows ([#4982](https://github.com/super-linter/super-linter/issues/4982)) ([ac4b767](https://github.com/super-linter/super-linter/commit/ac4b767bd7f94b948412c0fab2a5cec504039b21))
* remove unneeded Node dependencies ([#5093](https://github.com/super-linter/super-linter/issues/5093)) ([3847309](https://github.com/super-linter/super-linter/commit/3847309eca4516f9d90be2378343c512b123d792))
* run versions command in the slim stage ([#5127](https://github.com/super-linter/super-linter/issues/5127)) ([d5da0ce](https://github.com/super-linter/super-linter/commit/d5da0ceac93d03c8f4d19fc4130162cec18df530))
* set current version to 5.7.2 ([#5031](https://github.com/super-linter/super-linter/issues/5031)) ([238caec](https://github.com/super-linter/super-linter/commit/238caec66e249421170e16f707dfbd0f34103de2))
* simplify container image build ([22b8624](https://github.com/super-linter/super-linter/commit/22b8624f612cfd4752501a3944b35e7dd96ea7c8))
* simplify error code checks ([#5131](https://github.com/super-linter/super-linter/issues/5131)) ([05009f2](https://github.com/super-linter/super-linter/commit/05009f281693b7b3249a30b1c6f535339c96a028))
* simplify updateSSL ([#5130](https://github.com/super-linter/super-linter/issues/5130)) ([9bab4a9](https://github.com/super-linter/super-linter/commit/9bab4a90e81787c3596fc319460e522fd34246ec))
* standard image from base_image stage ([#5129](https://github.com/super-linter/super-linter/issues/5129)) ([877cdf4](https://github.com/super-linter/super-linter/commit/877cdf4ea17cb7e5bf8e54d0c53c09643fcf59ef))
* uninstall eslint-config-airbnb-typescript ([#5077](https://github.com/super-linter/super-linter/issues/5077)) ([65aae17](https://github.com/super-linter/super-linter/commit/65aae17a2689311e7c87d6095b37cdeccedcbe7d))
* update Dart, dart analyzer to 3.2.4 ([#5065](https://github.com/super-linter/super-linter/issues/5065)) ([4d9eaa5](https://github.com/super-linter/super-linter/commit/4d9eaa5c54eca4cc4e20da184744f42c92ac9a8a))
* update devcontainer definition ([#5132](https://github.com/super-linter/super-linter/issues/5132)) ([5e2c028](https://github.com/super-linter/super-linter/commit/5e2c028e0fd90209bcd27683e65193ab0ad71c45))
* update documentation ([#4981](https://github.com/super-linter/super-linter/issues/4981)) ([d465382](https://github.com/super-linter/super-linter/commit/d465382ed565d199b8cc0ad56a4b8884d7c62a0f))
* update Maintainer and authors ([#4948](https://github.com/super-linter/super-linter/issues/4948)) ([c5fa6a9](https://github.com/super-linter/super-linter/commit/c5fa6a999a758d8947b858918b0a6edce818d308))
* update prefix for dependency updates ([#5035](https://github.com/super-linter/super-linter/issues/5035)) ([0bb35c3](https://github.com/super-linter/super-linter/commit/0bb35c3e609677254c5942d52b9b60b12062c315))
* update react native dependencies ([#5152](https://github.com/super-linter/super-linter/issues/5152)) ([f3d1590](https://github.com/super-linter/super-linter/commit/f3d1590cd4faf682e1826137775dfdb9a8154de5))
* update tekton-lint to use its new namespace ([#5176](https://github.com/super-linter/super-linter/issues/5176)) ([e162b95](https://github.com/super-linter/super-linter/commit/e162b950f468a1d96cc03c5b956250a8cc20417a))
* use a base image ([#5033](https://github.com/super-linter/super-linter/issues/5033)) ([d8ca235](https://github.com/super-linter/super-linter/commit/d8ca23519b612ffbe245db76e1e77aa08f1fb388))
* use embedded checkstyle configuration files ([#5089](https://github.com/super-linter/super-linter/issues/5089)) ([9257ba8](https://github.com/super-linter/super-linter/commit/9257ba8af3e69fe30bcb9364167fabb738c70efb))
* validate container image labels ([#4926](https://github.com/super-linter/super-linter/issues/4926)) ([9869638](https://github.com/super-linter/super-linter/commit/986963813197fc7af4a438f3961c749da6f1d59d))
