import { writable } from "svelte/store";

export const PLAYER_DATA = writable(null);

export const SELECTED_PLAYER = writable(null);

export const PLAYER = writable<any[]>(null);

export const PLAYER_VEHICLES = writable<PLAYER_VEHICLES[]>(null);

interface PLAYER_DATA {
    id?: string;
    name?: string;
    cid?: string;
    license?: string;
    discord?: string;
    steam?: string;
    fivem?: string;
    vehicles?: PLAYER_VEHICLES[];
}

interface PLAYER_VEHICLES {
    id?: string;
    cid?: string;
    label?: string;
    brand?: string;
    model?: string;
    plate?: string;
    fuel?: string;
    engine?: string;
    body?: string;
}
