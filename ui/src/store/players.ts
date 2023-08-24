import { writable } from "svelte/store";

//  PLAYER_DATA is used for the player data and the rest under is used for all players in the server
export const PLAYER_DATA = writable(null);

export const SELECTED_PLAYER = writable(null);

export const PLAYER = writable<PLAYER_DATA[]>(null);

export const PLAYER_VEHICLES = writable<PLAYER_VEHICLES[]>(null);

interface PLAYER_DATA {
    id?: string;
    name?: string;
    cid?: string;
    license?: string;
    discord?: string;
    steam?: string;
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
