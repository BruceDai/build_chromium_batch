'use strict';

const fs = require('fs-extra');
const crypto = require('crypto');


const gen_md5 = (packageFile) => {
    const md5Content = crypto.createHash('md5').update(fs.readFileSync(packageFile)).digest('hex');
    const md5File = packageFile + '.md5';
    console.log(`Start to generate ${md5File} for ${packageFile}`);

    fs.writeFile(md5File, md5Content, (err) => {
        if (err) {
            console.error(err);
            throw err;
        }
    });
    console.log(`Successfully generated ${md5File} for ${packageFile}`);
};

gen_md5(process.argv[2]);