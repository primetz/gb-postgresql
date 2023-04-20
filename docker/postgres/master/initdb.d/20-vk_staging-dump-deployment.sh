#!/bin/bash

set -e

psql --username "$POSTGRES_USER" vk_staging < /vk.dump.sql
