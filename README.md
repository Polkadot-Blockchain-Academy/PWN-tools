

Included here are scripts to generate and verify a **Proof-of-Winning (PWN)** JSON payloads.

## 💻 Dependencies

PWN requires you come with:

- 🙋 A **SS58 compliant Address** that you have the private key for.
- 🏆 A **prize secret** from the Academy games (three words).

The scripts depend on installations of:

- `sha512sum` (via [OS package manager](https://unix.stackexchange.com/questions/426837/no-sha256sum-in-macos))
- `subkey` (via [cargo](https://github.com/paritytech/substrate/tree/master/bin/utils/subkey#install-with-cargo))
- `jq` (via [OS package manager](https://stedolan.github.io/jq/))
- `xxd` (via [OS package manager](https://unix.stackexchange.com/questions/1316/convert-ascii-code-to-hexadecimal-in-unix-shell-script))


These scripts gotta run 😉:

```sh
# Allow execution
chmod +x generate-proof-of-win-signature.sh generate-proof-of-win-private-key.sh verify-proof-of-win.sh
```

## 🔏 Generate PWN

- [./generate-proof-of-win-private-key.sh](./generate-proof-of-win-private-key.sh)
  - This uses `subkey` with a _private key_ provided.
- [./generate-proof-of-win-signature.sh](./generate-proof-of-win-signature.sh)
  - This uses a Polkadot.js API signed message.

🏆 You will also need a **prize secret** from the Academy games (three words) generated payload... but wait...

😱 _Share your secrets?!_
⛔ **_NO WAY, Jose!_**

> 🙈 Much like good practice in password checking, we don't request or store plain text!
>
> 🧂 Instead we [salt & hash](https://www.okta.com/blog/2019/03/what-are-salted-passwords-and-password-hashing/) your prize secrets
>
> 😅 _well... hash, but no salt for now, it's a TODO_

### 🏃 Running

Fire up these puppies, and **follow the prompts** - do so **_carefully and completely_**!

```sh
# Option with private key or mnemonic
./generate-proof-of-win-private-key.sh

# Option with Polkadot.js wallet
./generate-proof-of-win-signature.sh
```

Both scripts produce a payload file of `PWN-<your SS58 address here>.json`.

So as an example, `PWN-14XeJg226wvHG6PWmhKUsrv5PmeccjbXwFe9pVrBbryEWeZc.json` will look something like:

```json
{
  "message": "<Bytes>I LIKE WINNING! BOOOOO YAAAAAA!</Bytes>",
  "ss58Address": "14XeJg226wvHG6PWmhKUsrv5PmeccjbXwFe9pVrBbryEWeZc",
  "secretHash": "0x58cf16bcdceec9bce18246eeaa2f3358a2cdfdb7dc98a3d5f61da18f841b057369c58e64a456e236e853d853ef088a0eb57551a2a2b124c3060d5f402a2bf0a3",
  "signature": "0x78bea5e6ae9973c9842e33c1f37109fd5a8dc4f954cd22a133756a7590fffd0363f956afd24a16a6bcb00a3ce7bfdcc8045dad80b421bd01a8948ff9d2853e8a"
}
```

## 🔎 Verify PWN

-[./verify-proof-of-win.sh](./verify-proof-of-win.sh)

- This verifies a PWN json file correctly passes tests.

### 🏃 Running

```sh
# Option with private key or mnemonic
./verify-proof-of-win.sh <path to PWN JSON>
```

🎉 You know it's good if you get `Signature verifies correctly.`

😉 Otherwise you need to try again.

## 📬 Deliver your PWN

The Academy team will provide a place to copy& paste or upload the JSON file to assign your winnings!

## License

[Unlicense](./LICENSE)
