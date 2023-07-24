<p align="center">
<img alt="Polkadot Blockchain Academy" src="https://gateway.pinata.cloud/ipfs/QmdAthFeGzgsW65vhnSTBNN2wWdjL75MvU3tYxVgteaCzW" style="width:350px;">
<h1 align="center">Blockchain Academy<br>Proof-of-Winning Tools</h1>
</p>

Included here are scripts to generate and verify a **Proof-of-Winning (PWN)** JSON payloads.

## 💻 Dependencies

PWN requires you come with:

- 🙋 A **SS58 compliant Address** that you have the private key for.

The scripts depend on installations of:

- `sha512sum` (Install on: [MacOS](https://unix.stackexchange.com/questions/426837/no-sha256sum-in-macos) - [Linux & WSL](https://command-not-found.com/sha512sum) - from `coreutils` package)
- `jq` (Install on: [MacOS](https://stackoverflow.com/questions/37668134/how-to-install-jq-on-mac-on-the-command-line) - [Linux & WSL](https://command-not-found.com/jq))
- `subkey` (Install anywhere [with cargo](https://github.com/paritytech/substrate/tree/master/bin/utils/subkey), version 3 or above)

These scripts gotta run 😉:

```sh
# Allow execution
chmod +x generate-proof-of-win-signature.sh generate-proof-of-win-private-key.sh verify-proof-of-win.sh
```

---

## 🔏 Generate PWN

> 😱 You would just put secrets into some random executable you found online?!
>
> 🫠 ... and put your \_secrets into it?!

### ❗❗ BEFORE YOU START, READ THE `.sh` SCRIPTS INCLUDED HERE! ❗❗

- [./generate-proof-of-win-private-key.sh](./generate-proof-of-win-private-key.sh)
  - This uses `subkey` with a _private key_ provided.
- [./generate-proof-of-win-signature.sh](./generate-proof-of-win-signature.sh)
  - This uses a Polkadot.js API signed message.

### 🏃 Running

Fire up the option you want to use, and **follow the prompts** - do so **_carefully and completely_**!

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

---

## 🔎 Verify PWN

- [./verify-proof-of-win.sh](./verify-proof-of-win.sh)
  - This verifies a PWN json file correctly passes tests.
  - You can test this by checking the example above 😉.

### 🏃 Running

```sh
# Option with private key or mnemonic
./verify-proof-of-win.sh <path/to/PWN-$ADDRESS.json>
```

🎉 You know it's good if you get `Signature verifies correctly.`

😉 Otherwise you need to try again.

## 📬 Deliver your PWN

The Academy team will provide a place to copy& paste or upload the JSON file to assign your winnings!

## License

[Unlicense](./LICENSE)
