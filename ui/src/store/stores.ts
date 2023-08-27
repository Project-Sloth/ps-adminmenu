import { writable } from "svelte/store";

export const VISIBILITY = writable<boolean>(false);
export const BROWSER_MODE = writable<boolean>(false);
export const RESOURCE_NAME = writable<string>("");

export const DEV_MODE = writable<boolean>(false);

export const MENU_WIDE = writable<boolean>(false);
export const ACTIVE_PAGE = writable<string>("Actions");

export const searchActions = writable('');