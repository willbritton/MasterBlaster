#include <stdlib.h>
#include <stdbool.h>

typedef struct Entity
{
    unsigned char width;
    unsigned char height;
    bool collidable;
} Entity;

void DeleteEntity(Entity *entity)
{
    if(entity != NULL)
        free(entity);
}

void InitEntity(Entity* entity,
    unsigned char width,
    unsigned char height,
    bool collidable)
{
    entity->width = width;
    entity->height = height;
    entity->collidable = collidable;
}

void UpdateEntity(void)
{

}

void DrawEntity(void)
{

}

Entity* CreateEntity( void )
{
    struct Entity* entity = malloc(sizeof (struct Entity));
    
    if (entity == NULL)
        return NULL;

    InitEntity(entity, 1, 1, false);

    return entity;
}