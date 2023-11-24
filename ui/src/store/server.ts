import { writable } from "svelte/store";

export const RESOURCE = writable<RESOURCE_DATA[]>(null);
export const RESOURCES = writable<RESOURCE_DATA>(null);
export const COMMANDS = writable<COMMANDS_DATA[]>(null);

export const SERVER = writable<SERVER_DATA[]>(null);

interface RESOURCE_DATA {
    name?: string;
    author?: string;
    version?: string;
    description?: string;
    resourceState?: string;
}

interface SERVER_DATA {
    TotalCash?: string;
    TotalBank?: string;
    TotalItems?: string;
    CharacterCount?: string;
    VehicleCount?: string;
    BansCount?: string;
    UniquePlayers?: string;
}

interface COMMANDS_DATA {
    name?: string;
}
