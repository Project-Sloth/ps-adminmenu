import { writable } from "svelte/store";

export const TOGGLE_COORDS = writable<COORDS_DATA[]>(null);

interface COORDS_DATA {
    show: boolean;
    x: string;
    y: string;
    z: string;
    heading?: string;
}