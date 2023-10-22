import { writable } from "svelte/store";

export const VEHICLE_DATA = writable<any[]>(null);
export const ITEM_DATA = writable<any[]>(null);
export const JOB_DATA = writable<any[]>(null);
export const GANG_DATA = writable<any[]>(null);
export const LOCATION_DATA = writable<any[]>(null);
export const PED_LIST = writable<any[]>(null);