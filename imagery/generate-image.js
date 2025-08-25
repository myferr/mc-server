import { MinecraftServer } from "mjsrv";
import { argv } from "node:process";

MinecraftServer.create({
  version: `${argv[2]}`,
  motd: "Welcome to my server!",
  id: `${argv[3]}`,
}).then(() => {
  MinecraftServer.toContainer(`${argv[3]}`, { image: `${argv[3]}` });
});
