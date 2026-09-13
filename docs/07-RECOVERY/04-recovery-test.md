# Host Recovery Test

On disposable infrastructure, periodically prove that you can:

- create the `ktx` administrator manually;
- clone/check out the Host Core release;
- run bootstrap;
- prove temporary `ktx` password SSH;
- install and prove a workstation public key;
- run the SSHPiper cutover;
- confirm SSHPiper owns public 22 and OpenSSH owns only `127.0.0.1:2222`;
- confirm `ssh.socket` is masked and inactive;
- complete Host Core setup;
- restore the protected server-specific config/secrets needed by your environment;
- reattach a representative module and route.

Record anything that required tribal knowledge and put it back into this repository.
